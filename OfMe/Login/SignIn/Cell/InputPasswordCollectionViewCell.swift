import UIKit

class InputPasswordCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "InputPasswordCollectionViewCell"

    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        warningLabel.font = .Notos(.regular, size: 12)
        inputLabel.font = .Notos(.regular, size: 14)
        [passwordTextField,passwordCheckTextField].forEach {
            $0?.font = .Notos(.regular, size: 14)
            $0?.rightViewMode = .always
            $0?.addLeftPadding()
        }
        
    }
    
    func updateUI(for input: String,placeholder: String, placeholder2: String, submit: Bool, info: SignInfo) {
        inputLabel.text = input
        passwordTextField.placeholder = placeholder
        passwordCheckTextField.placeholder = placeholder2
        
        if submit {
            passwordTextField.rightView = makeImageView(isTrue: info.passwordCheck)
            passwordCheckTextField.rightView = makeImageView(isTrue: info.passwordVerifyCheck)
        }
    }
    
    func makeImageView(isTrue: Bool) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 25, height: 55))
        let imageView = UIImageView(image: UIImage(named: ImgName.imgName(of: .trueCheck)))
        if isTrue {
            imageView.image = UIImage(named: ImgName.imgName(of: .trueCheck))
        } else {
            imageView.image = UIImage(named: ImgName.imgName(of: .falseCheck))
        }
        imageView.frame = CGRect(x: 0, y: 25, width: imageView.frame.width, height: imageView.frame.height)
        view.addSubview(imageView)
        return view
    }

}
