import UIKit

class ArchiveWritePicker: NSObject {
    weak var charactorPicker: CharactorPickerView?
    weak var pickerView: UIDatePicker?
    weak var selectButton: UIButton?
    weak var selectCharactorButton: UIButton?
    
    var charctor: [String] = [
        "모스",
        "제이비",
        "리아",
        "이노",
        "시애나",
        "헤더",
        "로하",
        "로키",
        "폴",
        "주주",
        "옐로우",
        "마크",
        "뮤즈",
        "빈",
        "하이",
        "피즈",
        "베어"
    ]
    
    lazy var subView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.26)
        
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 35
        backgroundView.addSubview(view)
        view.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(350)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(UIImage(named: ImgName.imgName(of: .cancel)), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTouchDown(_:)), for: .touchDown)
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(27)
        }
        
        let pickerView = CharactorPickerView()
        self.charactorPicker = pickerView
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(150)
        }
        
        let selectButton = UIButton()
        self.selectCharactorButton = selectButton
        selectButton.setAttributedTitle(NSAttributedString(string: "선택", attributes: [
            .font : UIFont.Notos(.bold, size: 16),
            .foregroundColor : UIColor.mainBlue
        ]), for: .normal)
        selectButton.cornerRadius = 6
        selectButton.borderWidth = 1
        selectButton.borderColor = #colorLiteral(red: 0.7094730735, green: 0.7629908919, blue: 0.9359324574, alpha: 1)
        
        view.addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(90)
            make.height.equalTo(50)
        }
        
        return backgroundView
    }()

    
    lazy var mainView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.init(white: 0, alpha: 0.26)
        
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 35
        backgroundView.addSubview(view)
        view.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(350)
        }
        
        let cancelButton = UIButton()
        cancelButton.setImage(UIImage(named: ImgName.imgName(of: .cancel)), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelTouchDown(_:)), for: .touchDown)
        view.addSubview(cancelButton)
        cancelButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview().inset(27)
        }
        
        let pickerView = UIDatePicker()
        pickerView.locale = Locale(identifier: "ko_KR")
        pickerView.datePickerMode = .date
        pickerView.preferredDatePickerStyle = .wheels
        pickerView.setDate(Date(), animated: true)
        pickerView.minimumDate = Date(year: 2000, month: 1, day: 1)
        pickerView.maximumDate = Date(year: 2030, month: 12, day: 31)
        self.pickerView = pickerView
        self.pickerView?.tintColor = .mainBlue
        view.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.right.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(150)
        }
        
        let selectButton = UIButton()
        self.selectButton = selectButton
        selectButton.setAttributedTitle(NSAttributedString(string: "선택", attributes: [
            .font : UIFont.Notos(.bold, size: 16),
            .foregroundColor : UIColor.mainBlue
        ]), for: .normal)
        selectButton.cornerRadius = 6
        selectButton.borderWidth = 1
        selectButton.borderColor = #colorLiteral(red: 0.7094730735, green: 0.7629908919, blue: 0.9359324574, alpha: 1)
        
        view.addSubview(selectButton)
        selectButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.bottom.equalToSuperview().inset(90)
            make.height.equalTo(50)
        }
        
        return backgroundView
    }()
    
    func setConstraint(view: UIView) {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setSubConstraint(view: UIView) {
        view.addSubview(subView)
        subView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func cancelTouchDown(_ sender: UIButton) {
        mainView.removeFromSuperview()
    }
}
