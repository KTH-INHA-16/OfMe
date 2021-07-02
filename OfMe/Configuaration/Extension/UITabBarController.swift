import UIKit


extension UITabBarController {
    func testMiddleButton() -> UIButton {
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -30, width: 50, height: 50))
        middleBtn.backgroundColor = .white
        middleBtn.cornerRadius = middleBtn.bounds.width / 2
        middleBtn.setImage(UIImage(named: ImgName.imgName(of: .testIcon)), for: .normal)
        middleBtn.middleButtonShadow()
        
        self.tabBar.addSubview(middleBtn)
        self.view.layoutIfNeeded()
        return middleBtn
    }
    
    func normalMiddleButton() -> UIButton {
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2)-25, y: -30, width: 50, height: 50))
        middleBtn.backgroundColor = .white
        middleBtn.cornerRadius = middleBtn.bounds.width / 2
        middleBtn.setImage(UIImage(named: ImgName.imgName(of: .normalIcon)), for: .normal)
        middleBtn.isUserInteractionEnabled = false
        middleBtn.middleButtonShadow()
        
        self.tabBar.addSubview(middleBtn)
        self.view.layoutIfNeeded()
        return middleBtn
    }
    
    func circularProgressBar(duration: TimeInterval, progress: CGFloat) -> CircularProgressBar {
        let progressBar = CircularProgressBar(
            frame: CGRect(x: (view.center.x + 25),
                          y: tabBar.frame.origin.y+tabBar.frame.height/2,
                          width: 50,
                          height: 50), progress: progress)
        progressBar.progressAnimation(duration: duration)
        progressBar.center = CGPoint(x: view.center.x + 25, y: tabBar.frame.origin.y+tabBar.frame.height/2)
        self.tabBar.addSubview(progressBar)
        self.view.layoutIfNeeded()
        return progressBar
    }
}
