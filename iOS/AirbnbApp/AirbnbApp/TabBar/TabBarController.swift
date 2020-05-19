import UIKit

class TabBarController: UITabBarController {
    
    private var stayListViewController: StayListViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureTabBarControllers()
    }
    
    private func configureTabBarControllers() {
        stayListViewController = StayListViewController()
        
        viewControllers = [stayListViewController]
    }
}
