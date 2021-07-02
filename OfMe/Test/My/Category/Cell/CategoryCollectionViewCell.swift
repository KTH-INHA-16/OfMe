import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryCollectionViewCell"

    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.borderColor = .lightGray
        self.borderWidth = 1
        self.cornerRadius = 6
        
        descriptLabel.font = .Notos(.regular, size: 11)
        titleLabel.font = .Notos(.bold, size: 16)
        titleLabel.textColor = .mainBlue
    }
    
    func updateUI(index: Int, row: Int) {
        if index == row {
            self.backgroundColor = .mainBlue
            [descriptLabel, titleLabel].forEach { $0?.textColor = .white }
        } else {
            self.backgroundColor = .systemBackground
            descriptLabel.textColor = .label
            titleLabel.textColor = .mainBlue
        }
    }

}
