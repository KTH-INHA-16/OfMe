import UIKit

class TestMainViewController: BaseViewController {
    private var nickName: String = "메이커스짱짱"
    private let buttonText: [String] = ["유형 직접 선택하기", "테스트 시작하기"]

    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUP()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "나를 먼저 알기"
        middleButton = self.tabBarController?.normalMiddleButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    func setUP() {
        let text = "혹시 \(nickName)님은\n내가 어떤 유형인지\n알고 계신가요?"
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([
            .font : UIFont.Notos(.regular, size: 21),
            .foregroundColor : UIColor.label
        ], range: (text as NSString).range(of: text))
        attributedString.addAttributes([
            .font : UIFont.Notos(.bold, size: 21),
            .foregroundColor : UIColor.mainBlue
        ], range: (text as NSString).range(of: "내가 어떤 유형"))
        introLabel.attributedText = attributedString
        
        descriptLabel.font = .Notos(.regular, size: 12)
        descriptLabel.textColor = .gray3
        
        [categoryButton:buttonText[0], testButton:buttonText[1]].forEach {
            setButton(button: $0.key, text: $0.value)
        }
        
    }
    
    func setButton(button: UIButton, text: String) {
        button.setAttributedTitle(
            NSAttributedString(string: text,
                               attributes: [
                                .font : UIFont.Notos(.bold, size: 16),
                                .foregroundColor : UIColor.mainBlue
                               ]),
            for: .normal)
        button.cornerRadius = 6
        button.borderWidth = 1
        button.borderColor = .mainBlue
    }

}
