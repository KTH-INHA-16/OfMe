import UIKit

class QuestionMainViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var todayLabel: UILabel!
    @IBOutlet weak var dailyLabel: UILabel!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var dailyButton: UIButton!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var dailyCollectionView: UICollectionView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [todayLabel, dailyLabel, myLabel].forEach { $0.font = .Notos(.bold, size: 15) }
        scrollView.contentSize.width = UIScreen.main.bounds.width
        todayButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(UIScreen.main.bounds.width-90)
            make.centerY.equalTo(todayLabel)
            make.width.equalTo(55)
        }
        dailyButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(UIScreen.main.bounds.width-90)
            make.centerY.equalTo(dailyLabel)
            make.width.equalTo(55)
        }
        myButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(UIScreen.main.bounds.width-90)
            make.centerY.equalTo(myLabel)
            make.width.equalTo(55)
        }
        [todayCollectionView, dailyCollectionView, myCollectionView].forEach {
            $0?.snp.makeConstraints { make in
                make.width.equalTo(UIScreen.main.bounds.width)
            }
            $0?.register(UINib(nibName: QuestionMainCell.identfier, bundle: nil), forCellWithReuseIdentifier: QuestionMainCell.identfier)
            $0?.delegate = self
            $0?.dataSource = self
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Q&A"
    }
}

extension QuestionMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 0:
            return 5
        case 1:
            return 1
        default:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestionMainCell.identfier, for: indexPath) as? QuestionMainCell else {
            return UICollectionViewCell()
        }
        switch collectionView.tag {
        case 0:
            return cell
        case 1:
            return cell
        default:
            return cell
        }
    }
    
    
}

extension QuestionMainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 185)
    }
}
