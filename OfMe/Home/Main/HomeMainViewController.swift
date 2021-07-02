import UIKit

class HomeMainViewController: BaseViewController {
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
        middleButton = self.tabBarController?.testMiddleButton()
        middleButton?.addTarget(self, action: #selector(middleTouchDown(_:)), for: .touchDown)
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(bubbleImage)
        bubbleImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(self.view.frame.height*0.48)
            make.left.equalToSuperview().inset(self.view.frame.width*0.14)
        }
        bubbleImage.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(-20)
            make.left.right.equalToSuperview().inset(15)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let preview = preview {
            self.view.addSubview(preview.backgroundView)
            UIView.animate(withDuration: 0.3) {
                self.view.addSubview(preview.view)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        middleButton?.removeFromSuperview()
    }
    
    @objc func middleTouchDown(_ sender: UIButton) {
        let vc = TestMainViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
