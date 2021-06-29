import UIKit

class BaseViewController: UIViewController {
    
    public let backgroundView: UIView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.backgroundView.frame = UIScreen.main.bounds
        self.backgroundView.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        self.navigationController?.navigationBar
            .backgroundColor = .systemBackground
        self.navigationController?.navigationBar.barTintColor = .systemBackground
    }

}
