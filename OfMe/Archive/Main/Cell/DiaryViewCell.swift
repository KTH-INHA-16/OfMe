import UIKit

class DiaryViewCell: UICollectionViewCell {
    
    static let identifier = "DiaryViewCell"

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var charactorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var fixButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        timeLabel.font = .Notos(.regular, size: 12)
        titleLabel.font = .Notos(.bold, size: 15)
        titleLabel.textColor = .mainBlue
        charactorLabel.font = .Notos(.regular, size: 12)
        charactorLabel.textColor = .mainBlue
        
        contentLabel.font = .Notos(.regular, size: 12)
        contentLabel.textColor = .gray2
    }

}
