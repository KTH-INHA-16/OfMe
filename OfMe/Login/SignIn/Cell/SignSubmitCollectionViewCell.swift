import UIKit

class SignSubmitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SignSubmitCollectionViewCell"

    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        submitButton.cornerRadius = 6
        submitButton.setGradient(color1: .gradientLeft, color2: .gradientRight)
        submitButton.setAttributedTitle(
            NSAttributedString(string: "회원가입", attributes: [
                .font : UIFont.Notos(.bold, size: 16),
                .foregroundColor : UIColor.white
            ]), for: .normal)
        
        agreeButton.setAttributedTitle(
            NSAttributedString(string: "이용약관 동의", attributes: [
                .font : UIFont.Notos(.regular, size: 13),
                .foregroundColor : UIColor.black
            ]), for: .normal)
        
        
        descriptLabel.font = .Notos(.regular, size: 13)
        descriptLabel.textColor = .gray3
        
    }

}
