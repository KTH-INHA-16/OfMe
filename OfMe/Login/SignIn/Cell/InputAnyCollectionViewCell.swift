import UIKit

class InputAnyCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "InputAnyCollectionViewCell"

    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var warningLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        inputLabel.font = .Notos(.regular, size: 14)
        warningLabel.font = .Notos(.regular, size: 12)
        inputTextField.font = .Notos(.regular, size: 14)
        inputTextField.addLeftPadding()
        inputTextField.rightViewMode = .always
    }
    
    func updateUI(for input:String, where placeholder: String, info: SignInfo, row: Int, submit: Bool) {
        inputLabel.text = input
        inputTextField.placeholder = placeholder
        if submit {
            switch row {
            case 0:
                inputTextField.rightView = makeImageView(isTrue: info.emailCheck)
            default:
                inputTextField.rightView = makeImageView(isTrue: info.nickNameCheck)
            }
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
