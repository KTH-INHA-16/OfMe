import UIKit

class HomeMainViewController: BaseViewController {
    private var startTime: Date = Date()
    private var timer: Timer = Timer()
    private var count: Int = 0
    private var stopTimer: Timer = Timer()
    private var customView: HomeCustom = HomeCustom()
    private var isPlay: Bool = true
    private var isFirst: Bool = true
    private var preview: PreviewAdapter?
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
        label.text = "헤이든님!\n오늘의 친구를 만나보세요"
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        if isFirst {
            middleButton = self.tabBarController?.endMiddleButton()
            [bubbleImage, label].forEach { $0?.removeFromSuperview() }
            customView.setConstraint(view: self.view)
            customView.timeButton?.addTarget(self, action: #selector(timerTouchDown(_:)), for: .touchDown)
            setTimer(startTime: startTime)
        } else {
            middleButton = self.tabBarController?.testMiddleButton()
            middleButton?.addTarget(self, action: #selector(middleTouchDown(_:)), for: .touchDown)
            setFirst()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        middleButton?.removeFromSuperview()
    }
    
    func setTimer(startTime: Date) {
        DispatchQueue.main.async { [weak self] in
            self?.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] timer in
                let startSec = Int(Date().timeIntervalSince(startTime)) + self!.count
                let diffSec = startSec % 60
                var diffMin = startSec / 60
                let diffHour = diffMin / 3600
                diffMin = diffMin % 60
                self?.customView.timeLabel?.text = "\(diffHour > 0 ? "\(diffHour)시간 \(diffMin)분 \(diffSec)초" : "\(diffMin)분") \(diffSec)초"
            }
        }
    }
    
    func setFirst() {
        bubbleImage.image = UIImage(named: ImgName.imgName(of: .bubble))
        label.text = "헤이든님!\n오늘의 친구를 만나보세요"
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
        isFirst = true
    }
    
    @objc func timerTouchDown(_ sender: UIButton) {
        if isPlay {
            timer.invalidate()
            count = Int(Date().timeIntervalSince(startTime))
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
    
    @objc func middleTouchDown(_ sender: UIButton) {
        if let preview = preview {
            self.view.addSubview(preview.backgroundView)
            UIView.animate(withDuration: 0.3) {
                self.view.addSubview(preview.view)
            }
        }
//        let vc = TestMainViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
