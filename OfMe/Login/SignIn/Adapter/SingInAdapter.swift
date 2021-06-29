import UIKit

class SignInAdapter: NSObject {
    private weak var collectionView: UICollectionView!
    private let headerText: [String] = ["이메일 (아이디)", "비밀번호", "닉네임"]
    private let placeholderText: [String] = ["이메일 주소를 입력해주세요", "비밀번호를 입력해주세요\n비밀번호 확인", "닉네임을 입력해주세요"]
    private weak var warningIDLabel: UILabel?
    private weak var warningPWLabel: UILabel?
    private weak var warningNameLabel: UILabel?
    private var info: SignInfo = SignInfo()
    private var isSubmit: Bool = false
    private var selected: ((_ at: SignInfo)->Void)?
    
    init(of collectionView: UICollectionView,selected: @escaping ((_ at: SignInfo)->Void)) {
        super.init()
        self.selected = selected
        self.collectionView = collectionView
        self.collectionView.register(
            UINib(nibName: InputAnyCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: InputAnyCollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: InputPasswordCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: InputPasswordCollectionViewCell.identifier)
        self.collectionView.register(
            UINib(nibName: SignSubmitCollectionViewCell.identifier, bundle: nil),
            forCellWithReuseIdentifier: SignSubmitCollectionViewCell.identifier)
        setDelegate()
    }
    
    func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setDelegate(of textField:UITextField) {
        textField.delegate = self
    }
    
    @objc func agreeTouchDown(_ sender: UIButton) {
        switch info.check {
        case true:
            sender.setImage(UIImage(named: ImgName.imgName(of: .unchecked)), for: .normal)
        default:
            sender.setImage(UIImage(named: ImgName.imgName(of: .checked)), for: .normal)
        }
        info.check = !info.check
    }
    
    @objc func submitTouchDown(_ sender: UIButton) {
        guard let selected = selected else { return }
        selected(info)
        print(isSubmit)
        isSubmit = true
        collectionView.reloadData()
    }
}

extension SignInAdapter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0,2:
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: InputAnyCollectionViewCell.identifier, for: indexPath)
                    as? InputAnyCollectionViewCell else { return UICollectionViewCell() }
            if indexPath.row == 0 {
                cell.inputTextField.tag = 0
                warningIDLabel = cell.warningLabel
            } else {
                cell.inputTextField.tag = 3
                warningNameLabel = cell.warningLabel
            }
            setDelegate(of: cell.inputTextField)
            cell.updateUI(for: headerText[indexPath.row],
                          where: placeholderText[indexPath.row],
                          info: info,
                          row: indexPath.row,
                          submit: isSubmit)
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: InputPasswordCollectionViewCell.identifier, for: indexPath)
                    as? InputPasswordCollectionViewCell else { return UICollectionViewCell() }
            cell.passwordTextField.tag = 1
            cell.passwordCheckTextField.tag = 2
            warningPWLabel = cell.warningLabel
            [cell.passwordTextField,cell.passwordCheckTextField].forEach { setDelegate(of: $0) }
            let placeholderes = placeholderText[indexPath.row].components(separatedBy: "\n")
            cell.updateUI(for: headerText[indexPath.row],
                          placeholder: placeholderes[0],
                          placeholder2: placeholderes[1],
                          submit: isSubmit,
                          info: info)
            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SignSubmitCollectionViewCell.identifier, for: indexPath)
                    as? SignSubmitCollectionViewCell else { return UICollectionViewCell() }
            cell.agreeButton.addTarget(self, action: #selector(agreeTouchDown(_:)), for: .touchDown)
            cell.submitButton.addTarget(self, action: #selector(submitTouchDown(_:)), for: .touchDown)
            return cell
        }
        
    }
    
}


extension SignInAdapter: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.row {
        case 0,2:
            return CGSize(width: collectionView.frame.width, height: 120)
        case 1:
            return CGSize(width: collectionView.frame.width, height: 167)
        default:
            return CGSize(width: collectionView.frame.width, height: 270)
        }
    }
}

extension SignInAdapter: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            if let text = textField.text {
                info.email = text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        case 1:
            if let text = textField.text {
                info.password = text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        case 2:
            if let text = textField.text {
                info.password = text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        default:
            if let text = textField.text {
                info.password2 = text.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.endEditing(true)
        return true
    }
    
    
}
