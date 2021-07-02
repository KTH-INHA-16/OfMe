import UIKit

class TestConceptDetailFirstViewController: BaseViewController {
    private var circularProgressBar: CircularProgressBar?
    private var adapter: ConceptFirstAdapter?
    private var menu: ConceptFirstMenu?
    private var index: Int = -1
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = ConceptFirstMenu()
        menu?.nextButton.addTarget(self, action: #selector(nextTouchDown(_:)), for: .touchDown)
        adapter = ConceptFirstAdapter(of: collectionView) { idx in
            self.index = idx
            switch idx {
            case -1:
                self.menu?.nextButton.removeFromSuperview()
            default:
                self.menu?.setButton(view: self.view)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "컨셉 추천 받기"
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: 1/3+0.1)
        self.view.addSubview(circularProgressBar!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        circularProgressBar?.removeFromSuperview()
    }
    
    @objc func nextTouchDown(_ sender: UIButton) {
        let vc = TestConceptSecondViewController(firstIdx: index)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
