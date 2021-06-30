import UIKit


extension UITabBarController {
    func testMiddleButton() -> UIButton {
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -30, width: 50, height: 50))
        middleBtn.backgroundColor = .systemBackground
        middleBtn.cornerRadius = middleBtn.bounds.width / 2
        middleBtn.setImage(UIImage(named: ImgName.imgName(of: .testIcon)), for: .normal)
        
        self.tabBar.addSubview(middleBtn)
        self.view.layoutIfNeeded()
        return middleBtn
    }
    
    func normalMiddleButton() -> UIButton {
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -30, width: 50, height: 50))
        middleBtn.backgroundColor = .systemBackground
        middleBtn.cornerRadius = middleBtn.bounds.width / 2
        middleBtn.setImage(UIImage(named: ImgName.imgName(of: .normalIcon)), for: .normal)
        middleBtn.isUserInteractionEnabled = false
        
        self.tabBar.addSubview(middleBtn)
        self.view.layoutIfNeeded()
        return middleBtn
    }
}
