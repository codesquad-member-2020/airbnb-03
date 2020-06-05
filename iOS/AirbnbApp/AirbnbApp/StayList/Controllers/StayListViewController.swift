import UIKit

final class StayListViewController: UIViewController {
    
    private var searchFieldView: SearchFieldView!
    private var separatorView: SeparatorView!
    private var searchFilterView: SearchFilterView!
    private var stayListCollectionView: StayListCollectionView!
    private var stayListCollectionViewDataSource: StayListCollectionViewDataSource!
    private var stayListCollectionViewDelegate: StayListCollectionViewDelegate!
    private var mapButtonView: MapButtonView!
    private var searchTextFieldDelegate: SearchTextFieldDelegate!
    private var loadingView: LoadingView!
    
    private var searchFilterQuery: SearchFilterQuery = SearchFilterQuery()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
        configureCollectionView()
        configureTextFieldDelegate()
        configureSearchFilterViewTapDelegate()
        configureNotification()
        
        fetchStayList()
    }
    
    private func fetchStayList() {
        startLoadingView()
        StayListUseCase.getStayList(searchFilterQuery: searchFilterQuery) { (result) in
            switch result {
            case .success(let stayList):
                DispatchQueue.main.async {
                    self.stayListCollectionViewDataSource.configure(with: stayList)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentAlertController(with: error)
                }
            }
        }
    }
    
    private func presentAlertController(with error: Error) {
        let message = error.localizedDescription.components(separatedBy: ": ").last
        let alertController = UIAlertController(
            title: "Network Error",
            message: message,
            preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (_) in
            self.fetchStayList()
        }
        let doneAction = UIAlertAction(title: "Done", style: .default) { (_) in
            self.loadingView.stopLoadingAnimation()
        }
        alertController.addAction(retryAction)
        alertController.addAction(doneAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func startLoadingView() {
        loadingView.isHidden = false
        loadingView.alpha = 1
        loadingView.startLoadingAnimation()
    }
    
    private func dismissLoadingView() {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: .curveEaseOut,
            animations: {
                self.loadingView.alpha = 0
        }) { (_) in
            self.loadingView.stopLoadingAnimation()
            self.loadingView.isHidden = true
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func mapButtonTouched(_ sender: Any) {
        #warning("동작 확인용 VC")
        let viewController = UIViewController()
        viewController.modalPresentationStyle = .automatic // .fullScreen으로 변경할 것
        viewController.view.backgroundColor = .systemTeal
        present(viewController, animated: true)
    }
}

// MARK:- Notification Configuration

extension StayListViewController {
    private func configureNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didTapSaveButton),
            name: .didTapSaveButton,
            object: nil)
    }
    
    @objc private func didTapSaveButton(notification: Notification) {
        guard
            let locationOfButton = notification.userInfo?["location"] as? CGPoint,
            let indexPath = stayListCollectionView.indexPathForItem(at: locationOfButton),
            let stayCell = stayListCollectionView.cellForItem(at: indexPath) as? StayCell
        else {
            return
        }
        stayListCollectionViewDataSource.stayData(at: indexPath) { [weak self] (stay) in
            let isSaved: Bool = stay.saved
            if !isSaved {
                stayCell.animateSaveButton()
            }
            SavingStayUseCase.requestSave(
                stayID: stay.id,
                shouldCancel: isSaved) { (success) in
                    guard success
                    else {
                        DispatchQueue.main.async {
                            stayCell.updateSaveButton(with: isSaved)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        stayCell.updateSaveButton(with: !isSaved)
                        self?.stayListCollectionViewDataSource.updateSavedData(
                            at: indexPath,
                            saved: !isSaved)
                        self?.stayListCollectionView.reloadItems(at: [indexPath])
                    }
            }
        }
    }
}

// MARK:- Delegation Configuration

extension StayListViewController: StayListCollectionViewTapDelegate {
    func didTapCell(at indexPath: IndexPath) {
        stayListCollectionViewDataSource.idForCell(at: indexPath) { id in
            let detailViewController = StayDetailViewController()
            detailViewController.stayDetailID = id

            let viewController = UINavigationController(rootViewController: detailViewController)
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
    }
}

extension StayListViewController {
    private func configureCollectionViewDatasource() {
        stayListCollectionViewDataSource = StayListCollectionViewDataSource(
            changedHandler: { [weak self] (_) in
                DispatchQueue.main.async {
                    self?.stayListCollectionView.reloadData()
                    self?.dismissLoadingView()
                }
        })
    }
    
    private func configureCollectionViewDelegate() {
        stayListCollectionViewDelegate = StayListCollectionViewDelegate()
    }
    
    private func configureCollectionView() {
        configureCollectionViewDatasource()
        configureCollectionViewDelegate()
        
        stayListCollectionView.dataSource = stayListCollectionViewDataSource
        stayListCollectionView.delegate = stayListCollectionViewDelegate
        stayListCollectionView.tapDelegate = self
    }
    
    private func configureTextFieldDelegate() {
        searchTextFieldDelegate = SearchTextFieldDelegate()
        searchFieldView.configureTextFieldDelegate(searchTextFieldDelegate)
    }
}

// MARK:- Search Filter Delegation

extension StayListViewController: SearchFilterViewTapDelegate {
    private func configureSearchFilterViewTapDelegate() {
        searchFilterView.delegate = self
    }
    
    func didTapDatesFilter() {
        let datesFilterViewController = DatesFilterViewController()
        datesFilterViewController.searchDelegate = self
        present(datesFilterViewController, animated: true)
    }
    
    func didTapGuestsFilter() {
        let guestsFilterViewController = GuestsFilterViewController()
        guestsFilterViewController.searchDelegate = self
        present(guestsFilterViewController, animated: true)
        var guests = searchFilterQuery.filteredGuests()
        if guests == (0, 0, 0) {
            guests = (1, 0, 0)
        }
        guestsFilterViewController.updateGuests(guests)
    }
}

extension StayListViewController: DatesFilterSearchDelegate {
    func searchStayList(dates: (checkIn: String?, checkOut: String?)) {
        guard let checkIn = dates.checkIn, let checkOut = dates.checkOut
            else {
                return
        }
        searchFilterQuery.updateFilters(
            date: SearchFilterQuery.Date(checkIn: checkIn, checkOut: checkOut))
        fetchStayList()
    }
}

extension StayListViewController: GuestsFilterSearchDelegate {
    func searchStayList(guests: (adults: Int?, children: Int?, infants: Int?)) {
        searchFilterQuery.updateFilters(
            guest: SearchFilterQuery.Guest(
                adults: guests.adults,
                children: guests.children,
                infants: guests.infants))
        if searchFilterQuery.filteredGuests() != (1, 0, 0) {
            searchFilterView.updateGuestsFiltered(with: true)
            fetchStayList()
        } else {
            searchFilterView.updateGuestsFiltered(with: false)
        }
    }
}

// MARK:- UI & Layout

extension StayListViewController {
    private func configureUI() {
        view.backgroundColor = .white
        searchFieldView = SearchFieldView.loadFromXib()
        separatorView = SeparatorView()
        searchFilterView = SearchFilterView.loadFromXib()
        stayListCollectionView = StayListCollectionView()
        mapButtonView = MapButtonView.loadFromXib()
        loadingView = LoadingView()
    }
    
    private func configureLayout() {
        view.addSubviews(
            searchFieldView,
            separatorView,
            searchFilterView,
            stayListCollectionView,
            mapButtonView,
            loadingView
        )
        let sidePadding: CGFloat = 24.0
        searchFieldView.constraints(
            topAnchor: view.safeAreaLayoutGuide.topAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: nil, trailingAnchor: view.trailingAnchor,
            padding: .init( top: 16, left: sidePadding + 16, bottom: 0, right: sidePadding + 16),
            size: .init(width: 0, height: SearchFieldView.height))
        separatorView.constraints(
            topAnchor: searchFieldView.bottomAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: nil,
            trailingAnchor: view.trailingAnchor,
            padding: .init( top: 12, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 0.5))
        searchFilterView.constraints(
            topAnchor: searchFieldView.bottomAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: nil,
            trailingAnchor: view.trailingAnchor,
            padding: .init(top: 24, left: sidePadding, bottom: 0, right: sidePadding),
            size: .init(width: 0, height: SearchFilterView.height))
        stayListCollectionView.constraints(
            topAnchor: searchFilterView.bottomAnchor,
            leadingAnchor: view.leadingAnchor,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            trailingAnchor: view.trailingAnchor,
            padding: .init(top: 12, left: sidePadding, bottom: 0, right: sidePadding))
        mapButtonView.constraints(
            topAnchor: nil,
            leadingAnchor: nil,
            bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
            trailingAnchor: nil,
            padding: .init(top: 0, left: 0, bottom: 20, right: 0),
            size: CGSize(width: MapButtonView.width, height: MapButtonView.height))
        mapButtonView.centerXAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        loadingView.constraints(
            topAnchor: stayListCollectionView.topAnchor,
            leadingAnchor: stayListCollectionView.leadingAnchor,
            bottomAnchor: stayListCollectionView.bottomAnchor,
            trailingAnchor: stayListCollectionView.trailingAnchor)
    }
}
