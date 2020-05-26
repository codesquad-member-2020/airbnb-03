import UIKit

class TabBarController: UITabBarController {
    
    private var navViewController: UINavigationController!

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
        navViewController = UINavigationController(rootViewController: StayListViewController())
        viewControllers = [navViewController]

        let item = UITabBarItem(title: "EXPLORE", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        navViewController.tabBarItem = item
    }
}
