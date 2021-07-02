import UIKit

class TestDetailViewController: BaseViewController {
    private var step: Int = 1
    private var circularProgressBar: CircularProgressBar?
    internal let identifier = "TestDetailViewController"
    private var answer: [Int] = []
    private var highLightText: [String] = DummyData.highlightedSheet
    private var question: [String] = DummyData.descriptSheet
    private var answer1: [String] = DummyData.answerSheet1
    private var answer2: [String] = DummyData.answerSheet2
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var answerFirstButton: UIButton!
    @IBOutlet weak var answerSecondButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    init(step: Int) {
        super.init(nibName: identifier, bundle: Bundle.main)
        self.step = step
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: CGFloat(step)/12)
        self.view.addSubview(circularProgressBar!)
        
        setUP()
        setQuestion(step: Int(step))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "나를 먼저 알기"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        circularProgressBar?.removeFromSuperview()
    }
    
    @IBAction func firstTouchDown(_ sender: Any) {
        answer[step-1] = 0
        setSelected(button: answerFirstButton, text: answer1[step-1])
        setUnselected(button: answerSecondButton, text: answer2[step-1])
        nextButton.isUserInteractionEnabled = true
        nextButton.alpha = 1
    }
    
    @IBAction func secondTouchDown(_ sender: Any) {
        answer[step-1] = 1
        setSelected(button: answerSecondButton, text: answer2[step-1])
        setUnselected(button: answerFirstButton, text: answer1[step-1])
        nextButton.isUserInteractionEnabled = true
        nextButton.alpha = 1
    }
    
    @IBAction func nextTouchDown(_ sender: Any) {
        if step < 12 {
            step += 1
            setQuestion(step: step)
            circularProgressBar?.removeFromSuperview()
            circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: CGFloat(step)/12+0.1)
            self.view.addSubview(circularProgressBar!)
        } else {
            let vc = TestResultViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func prevTouchDown(_ sender: Any) {
        if step > 1 {
            step -= 1
        }
        setQuestion(step: step)
        circularProgressBar?.removeFromSuperview()
        circularProgressBar = self.tabBarController?.circularProgressBar(duration: 0.6, progress: CGFloat(step)/12+0.1)
        self.view.addSubview(circularProgressBar!)

    }
    
    func setUP() {
        answer = [Int].init(repeating: -1, count: 12)
        stepLabel.font = .Notos(.regular, size: 10)
        stepLabel.textColor = .gray3
        stepLabel.backgroundColor = .white
        stepLabel.text = "\(Int(step)) / 12"
        
        descriptLabel.font = .Notos(.regular, size: 18)
        stepLabel.textColor = .gray2
    }
    
    func setQuestion(step: Int) {
        print(answer[step-1])
        print(step)
        [answerFirstButton, answerSecondButton].forEach { $0?.setTitle(nil, for: .normal) }
        descriptLabel.makeHightledText(all: question[step-1], for: highLightText[step-1])
        stepLabel.text = "\(step) / 12"
        if answer[step-1] != -1 {
            switch answer[step-1] {
            case 0:
                setSelected(button: answerFirstButton, text: answer1[step-1])
                setUnselected(button: answerSecondButton, text: answer2[step-1])
            default:
                setSelected(button: answerSecondButton, text: answer2[step-1])
                setUnselected(button: answerFirstButton, text: answer1[step-1])
            }
            nextButton.isUserInteractionEnabled = true
            nextButton.alpha = 1
        } else {
            nextButton.alpha = 0.4
            nextButton.isUserInteractionEnabled = false
            setUnselected(button: answerFirstButton, text: answer1[step-1])
            setUnselected(button: answerSecondButton, text: answer2[step-1])
        }
        if step == 1 {
            prevButton.isUserInteractionEnabled = false
            prevButton.alpha = 0.4
        } else {
            prevButton.isUserInteractionEnabled = true
            prevButton.alpha = 1
        }
        if step != 12 {
            nextButton.setCustomTitle(text: "다음", font: .Notos(.bold, size: 16), color: .mainBlue)
        } else {
            nextButton.setCustomTitle(text: "완료", font: .Notos(.bold, size: 16), color: .mainBlue)
        }
    }
    
    func setSelected(button: UIButton, text: String) {
        button.backgroundColor = .mainBlue
        button.borderColor = .mainBlue
        button.setCustomTitle(text: text, font: .Notos(.bold, size: 14), color: .white)
        button.isUserInteractionEnabled = false
    }
    
    func setUnselected(button: UIButton, text: String) {
        button.backgroundColor = .white
        button.borderColor = .lightGray
        button.setCustomTitle(text: text, font: .Notos(.regular, size: 14), color: .gray2)
        button.isUserInteractionEnabled = true
    }

}
