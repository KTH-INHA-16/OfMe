import UIKit

class QuestionSubMainViewController: BaseViewController {
    private let titles: [String] = ["모든질문", "내가 공유한 Q&A", "확인완료", "미확인"]
    private var idx: Int = 0

    @IBOutlet weak var QACountLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [QACountLabel, pointLabel].forEach { $0.font = .Notos(.bold, size: 16) }
        collectionView.register(UINib(nibName: QuestionMenuCell.identifier, bundle: nil), forCellWithReuseIdentifier: QuestionMenuCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

}

extension QuestionSubMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionMenuCell.identifier, for: indexPath) as? QuestionMenuCell else {
            return UICollectionViewCell()
        }
        cell.updateUI(row: indexPath.row, idx: idx, title: titles[indexPath.row])
        return cell
    }
    
    
}

extension QuestionSubMainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        idx = indexPath.row
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: calculateWidth(collectionView: collectionView, row: indexPath.row)+50, height: 25)
    }
    
    func calculateWidth(collectionView: UICollectionView, row: Int) -> CGFloat {
        let view = UIView(frame: collectionView.frame)
        let label = UILabel(frame: collectionView.frame)
        label.font = .Notos(.regular, size: 12)
        label.text = titles[row]
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        label.sizeToFit()
        return label.frame.width
    }
}
