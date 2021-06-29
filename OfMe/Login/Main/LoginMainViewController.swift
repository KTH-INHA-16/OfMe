import UIKit

class LoginMainViewController: UIViewController {
    
    let signinText = "아직 회원이 아니라면, 회원가입하기"
    let signinFrontText = "아직 회원이 아니라면,"
    let signinBackText = "회원가입하기"
    let submitBtnText = "로그인"

    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        [idTextField,passwordTextField].forEach {
            $0?.delegate = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func signinButtonTouchDown(_ sender: Any) {
        let vc = SignInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setUI() {
        [idTextField,passwordTextField].forEach {
            $0?.addLeftPadding()
            $0?.font = .Notos(.regular, size: 14)
        }
        
        submitButton.cornerRadius = 6
        submitButton.setGradient(color1: .gradientLeft, color2: .gradientRight)
        submitButton.setAttributedTitle(NSAttributedString(string: submitBtnText, attributes: [
            .font : UIFont.Notos(.bold, size: 17),
            .foregroundColor : UIColor.white
        ]), for: .normal)
        
        let attributedText = NSMutableAttributedString(string: signinText)
        
        attributedText.addAttributes([
            .font : UIFont.Notos(.regular, size: 13),
            .foregroundColor : UIColor.gray3
        ], range: (signinText as NSString).range(of: signinFrontText))
        
        attributedText.addAttributes([
            .font : UIFont.Notos(.medium, size: 13),
            .foregroundColor : UIColor.gray2
        ], range: (signinText as NSString).range(of: signinBackText))
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.thick.rawValue,
                                    range: (signinText as NSString).range(of: signinBackText))
        attributedText.addAttribute(.underlineColor, value: UIColor.borderColor,
                                    range: (signinText as NSString).range(of: signinBackText))
        signButton.setAttributedTitle(attributedText, for: .normal)
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        if let keyboardFrame : NSValue = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.view.frame.origin.y = Device.bottomInset + Device.tabBarHeight - keyboardRectangle.height + 60
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }

}

extension LoginMainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true
    }
}
