import UIKit

class TestResultViewController: BaseViewController {
    
    private var circularProgressBar: CircularProgressBar?

    @IBOutlet weak var preTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDummy()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "나를 먼저 알기"
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: 1)
        self.view.addSubview(circularProgressBar!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        circularProgressBar?.removeFromSuperview()
    }
    
    @IBAction func conceptTouchDown(_ sender: Any) {
        let vc = TestConceptMainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setDummy() {
        let attributedString = NSMutableAttributedString(string: DummyData.pretestString)
        attributedString.addAttributes([
            .font : UIFont.Notos(.regular, size: 12),
            .foregroundColor : UIColor.gray2
        ], range: (DummyData.pretestString as NSString).range(of: DummyData.pretestString))
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue,
                                    range: (DummyData.pretestString as NSString).range(of: DummyData.pretestString))
        attributedString.addAttribute(.underlineColor, value: UIColor.gray2,
                                    range: (DummyData.pretestString as NSString).range(of: DummyData.pretestString))
        preTitleLabel.attributedText = attributedString
        
        titleLabel.makeHightledText(
            all: DummyData.titleResultString,
            for: DummyData.titleResultHLString,
            font: .Notos(.bold, size:22))
        keywordLabel.text = DummyData.keywordString
        aboutLabel.text = DummyData.aboutString
    }
}
