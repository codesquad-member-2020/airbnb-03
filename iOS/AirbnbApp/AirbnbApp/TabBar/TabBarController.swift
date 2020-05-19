import UIKit

class TabBarController: UITabBarController {
    
    private var stayListViewController: StayListViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTabBarControllers()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    private func configureTabBarControllers() {
        stayListViewController = StayListViewController()
        
        viewControllers = [stayListViewController]
    }
}
