import UIKit

class ConceptTestCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ConceptTestCollectionViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = .Notos(.regular, size: 14)
    }
    
    func updateUI(idx: Int, row: Int, title: String) {
        titleLabel.text = title
        if idx == row {
            self.backgroundColor = .mainBlue
            titleLabel.font = .Notos(.bold, size: 14)
            titleLabel.textColor = .white
        } else {
            self.backgroundColor = .systemBackground
            titleLabel.font = .Notos(.regular, size: 14)
            titleLabel.textColor = .label
        }
    }

}
