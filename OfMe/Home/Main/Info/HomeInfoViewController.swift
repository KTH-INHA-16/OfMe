import UIKit

class HomeInfoViewController: BaseViewController {
    private var adapter: ConceptResultAdapter?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        adapter = ConceptResultAdapter(of: collectionView, sub: pageControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "캐릭터 특징"
        middleButton = self.tabBarController?.endMiddleButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    func setUP() {
        titleLabel.font = .Notos(.bold, size: 22)
        titleLabel.textColor = .mainBlue
        
        mainLabel.font = .Notos(.regular, size: 13)
        subLabel.font = .Notos(.regular, size: 12)
        subLabel.textColor = .gray2
        
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
    }

}
