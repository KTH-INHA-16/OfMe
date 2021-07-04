import UIKit

class TestCategoryViewController: BaseViewController {
    private var adapter: CategoryAdapter?
    private var selectedIdx: Int = -1
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(
            NSAttributedString(string: "다음   ",
                               attributes: [
                                .font : UIFont.Notos(.bold, size: 16),
                                .foregroundColor : UIColor.mainBlue
                               ]), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .purple
        button.cornerRadius = 6
        button.tintColor = .mainBlue
        let image = UIImage(named: ImgName.imgName(of: .chevronRightMainBlue))
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(resultTouchDown(_:)), for: .touchDown)
        return button
    }()

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter = CategoryAdapter(of: collectionView) { index in
            self.selectedIdx = index
            if index != -1 {
                self.setNextButton()
            } else {
                self.removeNextButton()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "나를 먼저 알기"
        middleButton = self.tabBarController?.normalMiddleButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
    }
    
    func setNextButton() {
        self.view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(80)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(55)
        }
    }
    
    func removeNextButton() {
        nextButton.removeFromSuperview()
    }
    
    @objc func resultTouchDown(_ sender: UIButton) {
        let vc = TestResultViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
