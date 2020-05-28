import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureTabBarControllers()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        tabBar.tintColor = UIColor(named: "stay.tintcolor")
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }
    
    private func configureTabBarControllers() {
        viewControllers = [makeRootViewControllerNamedExplore()]
    }

    private func makeRootViewControllerNamedExplore() -> UIViewController {
        let navViewController = UINavigationController(rootViewController: StayListViewController())

        let item = UITabBarItem(title: "EXPLORE", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        navViewController.tabBarItem = item

        return navViewController
    }
}
