import UIKit

class QuestionMainCell: UICollectionViewCell {
    
    static let identfier = "QuestionMainCell"

    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var changeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dotView.backgroundColor = .mainBlue
        conditionLabel.font = .Notos(.regular, size: 10)
        titleLabel.font = .Notos(.regular, size: 14)
        conditionLabel.textColor = .gray3
    }

}
