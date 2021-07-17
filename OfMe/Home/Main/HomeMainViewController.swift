import UIKit
import Kingfisher

class HomeMainViewController: BaseViewController {
    private let dataManager = HomeMainDataManager()
    private var data: [CharacterResult] = []
    private var actionData: [CharacterAction] = []
    private var startTime: Date = Date()
    private var timer: Timer = Timer()
    private var time: Int = 0
    private var stopTimer: Timer = Timer()
    private var actionAdapter: ActionAdapter = ActionAdapter()
    private var customView: HomeCustom = HomeCustom()
    private let finishView = FinishSubView()
    private var isPlay: Bool = true
    private var isFirst: Bool = false
    private var isFirstTime: Bool = false
    private var preview: PreviewAdapter?
    private var idx: Int = 5
    private lazy var bubbleImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ImgName.imgName(of: .bubble))
        return imageView
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .Notos(.regular, size: 12)
        label.textColor = .gray3
        label.text = "오늘의 친구를 만나보세요"
        return label
    }()

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preview = PreviewAdapter { button in
            switch button.tag {
            case 0:
                self.preview?.backgroundView.removeFromSuperview()
                self.preview?.view.removeFromSuperview()
            case 1:
                let vc = TestMainViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            default:
                let vc = TestConceptMainViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        customView.infoButton.addTarget(self, action: #selector(infoTouchDown(_:)), for: .touchDown)
        changeIsFirst()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.middleButton?.removeFromSuperview()
        if !data.isEmpty {
            self.middleButton = self.tabBarController?.endMiddleButton()
        } else {
            self.middleButton = self.tabBarController?.testMiddleButton()
        }
        self.middleButton?.addTarget(self, action: #selector(self.middleTouchDown(_:)), for: .touchDown)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        middleButton?.removeFromSuperview()
        dataManager.patchCharacterTime(time: time)
    }
    
    func setTimer(startTime: Date) {
        DispatchQueue.main.async { [weak self] in
            self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                let startSec = Int(Date().timeIntervalSince(startTime)) + self!.time * 60
                var diffMin = startSec / 60
                let diffHour = diffMin / 60
                diffMin = diffMin % 60
                self?.customView.timeLabel?.text = "\(diffHour > 0 ? "\(diffHour)시간 \(diffMin)분" : "\(diffMin)분")"
            }
        }
    }
    
    func setFirst() {
        bubbleImage.image = UIImage(named: ImgName.imgName(of: .bubble))
        label.text = "오늘의 친구를 만나보세요"
        self.view.addSubview(bubbleImage)
        bubbleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(self.view.frame.height*0.48)
            make.left.equalToSuperview().inset(self.view.frame.width*0.14)
        }
        bubbleImage.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(-30)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
    func setStop() {
        bubbleImage.image = UIImage(named: ImgName.imgName(of: .bubbleRight))
        label.text = "나 여기 있어..!"
        self.view.addSubview(bubbleImage)
        bubbleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(self.view.frame.height*0.6)
            make.left.equalToSuperview().inset(self.view.frame.width*0.37)
        }
        bubbleImage.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(-30)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
    func changeIsFirst() {
        [self.bubbleImage, self.label].forEach { $0?.removeFromSuperview() }
        [customView.changeButton,customView.charactorImageView,customView.infoButton,customView.menu].forEach {
            $0.removeFromSuperview()
        }
        
        dataManager.getCharacter { result in
            self.data = result
            self.middleButton?.removeFromSuperview()
            if !result.isEmpty {
                self.time = result.last!.timer
                self.middleButton = self.tabBarController?.endMiddleButton()
                [self.bubbleImage, self.label].forEach { $0?.removeFromSuperview() }
                self.customView.setConstraint(view: self.view)
                self.customView.timeButton?.addTarget(self, action: #selector(self.timerTouchDown(_:)), for: .touchDown)
                self.customView.changeButton.addTarget(self, action: #selector(self.changeTouchDown(_:)), for: .touchDown)
                if let url = URL(string: result.last!.conceptImg) {
                    self.customView.charactorImageView.kf.setImage(with: url)
                }
                self.customView.titleLabel?.text = "\(result.last!.nickname)과 \(result.last!.name)과 함께한지"
                self.setTimer(startTime: self.startTime)
                self.isFirst = true
                self.middleButton?.addTarget(self, action: #selector(self.middleTouchDown(_:)), for: .touchDown)
            } else {
                self.middleButton = self.tabBarController?.testMiddleButton()
                self.middleButton?.addTarget(self, action: #selector(self.middleTouchDown(_:)), for: .touchDown)
                self.setFirst()
                self.isFirst = false
            }
        }
        dataManager.getCharacterAction { result in
            self.actionData = result
        }
    }
    
    func setCharactor(idx: Int) {
        customView.changeButton.setImage(UIImage(named: ImgName.imgName(of: .moon)), for: .normal)
        backgroundImageView.image = UIImage(named: ImgName.imgName(of: .background))
        if !actionData.isEmpty {
            switch idx {
            case 0:
                setAnimation(img1: actionData[0].ActionImg, img2: actionData[1].ActionImg)
            case 1:
                setAnimation(img1: actionData[2].ActionImg, img2: actionData[3].ActionImg)
            case 2:
                setAnimation(img1: actionData[4].ActionImg, img2: actionData[5].ActionImg)
            case 3:
                customView.changeButton.setImage(UIImage(named: ImgName.imgName(of: .sunButton)), for: .normal)
                backgroundImageView.image = UIImage(named: ImgName.imgName(of: .backgroundSun))
                setAnimation(img1: actionData[6].ActionImg, img2: actionData[7].ActionImg)
            case 4:
                setAnimation(img1: actionData[8].ActionImg, img2: actionData[9].ActionImg)
            default:
                setAnimation(img1: actionData[10].ActionImg, img2: actionData[11].ActionImg)
            }
        }
    }
    
    func setAnimation(img1: String, img2: String) {
        var time:Int = 0
        var animationTimer = Timer()
        animationTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if time == 0 {
                if let url = URL(string: img1) {
                    self.customView.charactorImageView.kf.setImage(with: url)
                }
            } else {
                if let url = URL(string: img2) {
                    self.customView.charactorImageView.kf.setImage(with: url)
                }
                animationTimer.invalidate()
            }
            time += 1
        }
    }
    
    @objc func timerTouchDown(_ sender: UIButton) {
        if isPlay {
            timer.invalidate()
            time = Int(Date().timeIntervalSince(startTime)) / 60
            dataManager.patchCharacterTime(time: time)
            var cnt = 0
            customView.timeButton?.isUserInteractionEnabled = false
            stopTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                if cnt == 0 {
                    self?.backgroundImageView.image = UIImage(named: ImgName.imgName(of: .backgroundStop))
                    self?.customView.charactorImageView.image = UIImage(named: ImgName.imgName(of: .defaultStop))
                } else {
                    self?.backgroundImageView.image = UIImage(named: ImgName.imgName(of: .background))
                    self?.customView.charactorImageView.image = nil
                    self?.setStop()
                    self?.customView.timeButton?.isUserInteractionEnabled = true
                    self?.timer.invalidate()
                    self?.stopTimer.invalidate()
                }
                cnt += 1
            }
        } else {
            [bubbleImage,label].forEach { $0.removeFromSuperview() }
            customView.charactorImageView.image = UIImage(named: ImgName.imgName(of: .defaultImg))
            startTime = Date()
            setTimer(startTime: startTime)
        }
        isPlay = !isPlay
        customView.setButton(customView.timeButton!, isPlay: isPlay)
    }
    
    @objc func infoTouchDown(_ sender: UIButton) {
        var idx: Int
        if let data = data.last {
            idx = data.id
            let vc = HomeInfoViewController(idx: idx)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func middleTouchDown(_ sender: UIButton) {
        if isFirst {
            finishView.setConstraint(view: self.view)
            finishView.confirmButton?.addTarget(self, action: #selector(finishTouchDown), for: .touchDown)
        } else {
            if let preview = preview {
                self.view.addSubview(preview.backgroundView)
                self.view.addSubview(preview.view)
            }
        }
    }
    
    @objc func finishTouchDown() {
        if let data = data.last {
            finishView.mainView.removeFromSuperview()
            let vc = HomeFinishViewController(data: data, time: time)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func changeTouchDown(_ sender: UIButton) {
        actionAdapter.setConstraint(view: self.view)
        actionAdapter.applyButton?.addTarget(self, action: #selector(applyTouchDown(_:)), for: .touchDown)
    }
    
    @objc func applyTouchDown(_ sender: UIButton) {
        actionAdapter.menuView.removeFromSuperview()
        idx = sender.tag
        setCharactor(idx: idx)
    }
}
