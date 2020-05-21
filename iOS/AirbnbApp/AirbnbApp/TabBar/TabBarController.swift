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

        let item = UITabBarItem(title: "Stay", image: UIImage(systemName: "bed.double.fill"), tag: 0)
        stayListViewController.tabBarItem = item
    }
}
