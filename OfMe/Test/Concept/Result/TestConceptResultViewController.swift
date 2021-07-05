import UIKit

class TestConceptResultViewController: BaseViewController {
    private var circularProgressBar: CircularProgressBar?
    private var data: ConceptDummy = ConceptDummy()
    private var adapter: ConceptResultAdapter?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var charactorLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var charactorImageView: UIImageView!
    @IBOutlet weak var charactorPageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUP()
        adapter = ConceptResultAdapter(of: collectionView, sub: charactorPageControl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "컨셉 추천 받기"
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: 1)
        self.view.addSubview(circularProgressBar!)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        circularProgressBar?.removeFromSuperview()
    }
    
    @IBAction func startTouchDown(_ sender: Any) {
        self.navigationController?.viewControllers.forEach {
            if $0 is HomeMainViewController {
                if let vc = $0 as? HomeMainViewController {
                    vc.changeIsFirst()
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        }
    }
    
    func setUP() {
        charactorLabel.text = data.charactorText
        charactorLabel.font = .Notos(.bold, size: 22)
        charactorLabel.textColor = .mainBlue
        
        let attirbutedText = NSMutableAttributedString(string: data.titleText)
        attirbutedText.addAttributes([
            .font : UIFont.Notos(.regular, size: 12),
            .foregroundColor : UIColor.gray2
        ], range: (data.titleText as NSString).range(of: data.titleText))
        attirbutedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue,
                                    range: (data.titleText as NSString).range(of: data.titleText))
        attirbutedText.addAttribute(.underlineColor, value: UIColor.gray2,
                                    range: (data.titleText as NSString).range(of: data.titleText))
        titleLabel.attributedText = attirbutedText
        
        descriptLabel.font = .Notos(.bold, size: 12)
        descriptLabel.textColor = .gray2
        descriptLabel.text = data.charactorDescriptText
        
        charactorPageControl.numberOfPages = 5
        charactorPageControl.currentPage = 0
    }

}
