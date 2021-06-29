import UIKit

class BaseTabBarViewController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: ViewController 만드는 로직을 따로
//    let homeMainViewController = HomeMainViewController()
//    let qrMainViewController = QRMainViewController()
//    let offlineViewController = OfflineMainViewController()
//    let archiveMainViewController = ArchiveMainViewController()
//    let myInfoMainViewController = MyInfoMainViewController()
    
    //MARK: 제목들 + 이미지 이름 Constant쪽으로 빼놓기, image literar로 변경, namespace로 수정
//    let qrTabBarItem = UITabBarItem(title: "QR스캐너", image: UIImage(named: "TabBarQR"), selectedImage: UIImage(named: "TabBarQR"))
//    let homeTabBarItem = UITabBarItem(title: "Home".localized, image: UIImage(named: "TabBarHome"), selectedImage: UIImage(named: "TabBarHome"))
//    let offlineTabBarItem = UITabBarItem(title: "콘텐츠", image: UIImage(named: "TabBarContent"), selectedImage: UIImage(named: "TabBarContent"))
//    let archiveTabBarItem = UITabBarItem(title: "Archive".localized, image: UIImage(named: "TabBarArchive"), selectedImage: UIImage(named: "TabBarArchive"))
//    let myInfoTabBarItem = UITabBarItem(title: "메뉴", image: UIImage(named: "TabBarMenu"), selectedImage: UIImage(named: "TabBarMenu"))

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let qrNavigationController = UINavigationController(rootViewController: QRMainViewController())
//        let homeNavigationController = UINavigationController(rootViewController: homeMainViewController)
//        let offlineNavigationController = UINavigationController(rootViewController: OfflineMainViewController())
//        let archiveNavigationController = UINavigationController(rootViewController: archiveMainViewController)
//        let myInfoNavigationController = UINavigationController(rootViewController: myInfoMainViewController)
//
//        //MARK: TAG 빼기
//        homeTabBarItem.tag = 0
//        homeNavigationController.tabBarItem  = homeTabBarItem
//
//        offlineTabBarItem.tag = 1
//        offlineNavigationController.tabBarItem = offlineTabBarItem
//
//        qrTabBarItem.tag = 2
//        qrNavigationController.tabBarItem = qrTabBarItem
//
//        archiveTabBarItem.tag = 3
//        archiveNavigationController.tabBarItem = archiveTabBarItem
//
//        myInfoTabBarItem.tag = 4
//        myInfoNavigationController.tabBarItem = myInfoTabBarItem
//
//        self.viewControllers = [
//            homeNavigationController,
//            offlineNavigationController,
//            qrNavigationController,
//            archiveNavigationController,
//            myInfoNavigationController
//        ]
//        self.delegate = self
        
    }

}
