import UIKit

class ConceptResultAdapter: NSObject {
    private weak var collectionView: UICollectionView!
    private weak var pageControl: UIPageControl!
    
    init(of collectionView: UICollectionView, sub pageControl: UIPageControl) {
        super.init()
        self.pageControl = pageControl
        self.pageControl.isUserInteractionEnabled = false
        self.collectionView = collectionView
        self.collectionView.tag = 1
        self.collectionView.register(
            UINib(nibName: ConceptResultTextCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ConceptResultTextCell.identifier)
        self.collectionView.register(
            UINib(nibName: ConceptResultMusicCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: ConceptResultMusicCell.identifier)
        
        setDelegate()
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

extension ConceptResultAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < 4 {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ConceptResultTextCell.identifier, for: indexPath) as? ConceptResultTextCell else {
                return UICollectionViewCell()
            }
            cell.updateUI(idx: indexPath.row)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ConceptResultMusicCell.identifier, for: indexPath) as? ConceptResultMusicCell else {
                return UICollectionViewCell()
            }
            cell.updateUI()
            return cell
        }
    }
    
}

extension ConceptResultAdapter: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }
}

extension ConceptResultAdapter: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 1 {
            pageControl.currentPage = Int(floor(collectionView.contentOffset.x / collectionView.frame.width))
        }
    }
}
