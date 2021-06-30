import UIKit

class CustomTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    let homeVC = HomeMainViewController()
    let questionVC = QuestionMainViewController()
    let archiveVC = ArchiveMainViewController()
    let myinfoVC = MyInfoMainViewController()
    
    let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(named: ImgName.imgName(of: .homeIcon)), tag: 0)
    let questionTabBarItem = UITabBarItem(title: "기록", image: UIImage(named: ImgName.imgName(of: .archiveIcon)), tag: 1)
    let archiveTabBarItem = UITabBarItem(title: "Q&A", image: UIImage(named: ImgName.imgName(of: .questionIcon)), tag: 2)
    let myinfoTabBarItem = UITabBarItem(title: "마이", image: UIImage(named: ImgName.imgName(of: .myInfoIcon)), tag: 3)

//    required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)!
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        let tabBar = { () -> CustomTabBar in
            let tabBar = CustomTabBar()
            tabBar.delegate = self
            return tabBar
        }()
        self.setValue(tabBar, forKey: "tabBar")
        
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let questionNavVC = UINavigationController(rootViewController: questionVC)
        let archiveNavVC = UINavigationController(rootViewController: archiveVC)
        let myinfoNavVC = UINavigationController(rootViewController: myinfoVC)
        
        homeNavVC.tabBarItem = homeTabBarItem
        questionNavVC.tabBarItem = questionTabBarItem
        archiveNavVC.tabBarItem = archiveTabBarItem
        myinfoNavVC.tabBarItem = myinfoTabBarItem
        
        self.viewControllers = [
            homeNavVC,
            questionNavVC,
            archiveNavVC,
            myinfoNavVC
        ]
        
    }
    
    override func viewWillLayoutSubviews() {
        tabBar.tintColor = .tabBarBlue
        tabBar.items?[0].titlePositionAdjustment.horizontal = 15
        tabBar.items?[1].titlePositionAdjustment.horizontal = -15
        tabBar.items?[2].titlePositionAdjustment.horizontal = 15
        tabBar.items?[3].titlePositionAdjustment.horizontal = -15
    }

    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 2   //to select the middle tab. use "1" if you have only 3 tabs.
    }

}
