import UIKit

class SignInViewController: UIViewController {
    
    private var adapter: SignInAdapter?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        adapter = SignInAdapter(of: collectionView) { info in
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidDisappear(_ animated: Bool) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    func setUI() {
        self.navigationController?.navigationBar.barTintColor = self.view.backgroundColor
        setCustomBackButton()
        self.navigationItem.title = "회원가입"
        self.navigationController?.navigationBar.titleTextAttributes = [
            .font : UIFont.Notos(.bold, size: 14)
        ]
    }
    
    func setCustomBackButton() {
        let backImage = UIImage(named: ImgName.imgName(of: .chevronLeft))
        self.navigationController?.navigationBar.backIndicatorImage = backImage?.withRenderingMode(.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage =
            backImage?.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem()
        backButton.title = " "
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}
