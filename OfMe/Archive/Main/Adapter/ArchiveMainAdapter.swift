import UIKit

class ArchiveMainAdapter: NSObject {
    private weak var collectionView: UICollectionView!
    
    init(of collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        self.collectionView.register(UINib(nibName: DiaryViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DiaryViewCell.identifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
}

extension ArchiveMainAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: DiaryViewCell.identifier,
                for: indexPath) as? DiaryViewCell else { return UICollectionViewCell() }
        return cell
    }
}

extension ArchiveMainAdapter: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width-30, height: collectionView.frame.height-50)
    }
}
