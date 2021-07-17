import UIKit
import ImagePicker

class ArchiveWriteViewController: BaseViewController {
    private var info: WriteInfo = WriteInfo()
    private let pickerView: ArchiveWritePicker = ArchiveWritePicker()
    private var date: Date = Date()
    private var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
            if images.count == 0 {
                setImageButton()
            } else {
                addImageButton.removeFromSuperview()
            }
        }
    }
    
    lazy var rightButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.tintColor = .label
        button.title = "등록"
        button.setTitleTextAttributes([
            .font : UIFont.Notos(.bold, size: 14),
            .foregroundColor : UIColor.mainBlue
        ], for: .normal)
        button.isEnabled = false
        button.target = self
        button.action = #selector(writeTouchDown)
        return button
    }()
    
    private lazy var addImageButton: UIButton = {
        let button = UIButton()
        button.imageEdgeInsets.left = -20
        button.setImage(UIImage(named: ImgName.imgName(of: .image)), for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "이미지 첨부",
                                                     attributes: [
                                                        .font : UIFont.Notos(.regular, size: 14),
                                                        .foregroundColor : UIColor.mainBlue
                                                     ]), for: .normal)
        button.addTarget(self, action: #selector(addImageTouchDown), for: .touchDown)
        return button
    }()
    
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var charactorTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonText()
        collectionView.frame.size = CGSize(width: UIScreen.main.bounds.width-40, height: 95)
        titleTextField.frame.size = CGSize(width: UIScreen.main.bounds.width-40, height: 35)
        [titleTextField, charactorTextField, collectionView].forEach {
            $0.snp.makeConstraints { make in
                make.width.equalTo(UIScreen.main.bounds.width-40)
            }
        }
        let touch = UITapGestureRecognizer(target: self, action: #selector(singleTapGestureCaptured(gesture:)))
        scrollView.addGestureRecognizer(touch)
        setUnderLine(of: titleTextField)
        setUnderLine(of: charactorTextField)
        titleTextField.font = .Notos(.regular, size: 14)
        charactorTextField.font = .Notos(.bold, size: 14)
        charactorTextField.textColor = .mainBlue
        contentTextView.font = .Notos(.regular, size: 12)
        contentTextView.text = "내용을 입력해주세요."
        contentTextView.textColor = .lightGray
        contentTextView.textContainer.maximumNumberOfLines = 15
        contentTextView.delegate = self
        collectionView.addDashedBorder()
        setImageButton()
        
        collectionView.register(UINib(nibName: WriteImageCell.identifier, bundle: nil), forCellWithReuseIdentifier: WriteImageCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        charactorTextField.delegate = self
        titleTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "컨셉 기록"
        self.navigationItem.rightBarButtonItem = rightButton
        middleButton = self.tabBarController?.normalMiddleButton()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(_:)),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        middleButton?.removeFromSuperview()
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func dateTouchDown(_ sender: Any) {
        pickerView.setConstraint(view: self.view)
        pickerView.selectButton?.addTarget(self, action: #selector(selectTouchDown), for: .touchDown)
    }
    
    func setImageButton() {
        self.view.addSubview(addImageButton)
        addImageButton.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(collectionView)
        }
    }
    
    func setUnderLine(of textField: UITextField) {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: textField.frame.size.height-1, width: textField.frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        textField.layer.addSublayer(border)
    }
    
    func setButtonText() {
        dateButton.setAttributedTitle(NSAttributedString(string: date.fullText+"  ", attributes: [
            .font : UIFont.Notos(.bold, size: 12),
            .foregroundColor : UIColor.mainBlue
        ]), for: .normal)
    }
    
    func checkButton() {
        if info.content != "" && info.idx != -1 && info.title != "" {
            rightButton.isEnabled = true
        } else {
            rightButton.isEnabled = false
        }
    }
    
    @objc func addImageTouchDown() {
        let configuration = Configuration()
        configuration.doneButtonTitle = "완료"
        configuration.cancelButtonTitle = "취소"
        configuration.OKButtonTitle = "확인"
        configuration.recordLocation = false
        configuration.canRotateCamera = false
        let imagePickerController = ImagePickerController(configuration: configuration)
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 4
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func writeTouchDown() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func selectTouchDown() {
        date = pickerView.pickerView!.date
        pickerView.mainView.removeFromSuperview()
        setButtonText()
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func singleTapGestureCaptured(gesture: UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    @objc func removeTouchDown(_ sender: UIButton) {
        images.remove(at: sender.tag)
    }
    
    @objc func charactorTouchDown() {
        pickerView.setSubConstraint(view: self.view)
        pickerView.selectCharactorButton?.addTarget(self, action: #selector(setCharactor), for: .touchDown)
    }
    
    @objc func setCharactor() {
        info.idx = pickerView.charactorPicker!.selectedRow(inComponent: 0)
        charactorTextField.text = pickerView.charactorPicker?.charctor[info.idx]
        pickerView.subView.removeFromSuperview()
        checkButton()
    }
}

extension ArchiveWriteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WriteImageCell.identifier, for: indexPath) as? WriteImageCell
        else { return UICollectionViewCell() }
        cell.cancelButton.tag = indexPath.row
        cell.cancelButton.addTarget(self, action: #selector(removeTouchDown(_:)), for: .touchDown)
        cell.updateUI(image: images[indexPath.row])
        return cell
    }
    
    
}

extension ArchiveWriteViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: collectionView.frame.height)
    }
}

extension ArchiveWriteViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = Device.bottomInset + Device.tabBarHeight - 200
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요."
            textView.textColor = UIColor.lightGray
        }
        self.view.frame.origin.y = 0
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        info.content = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        checkButton()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        return numberOfChars < 350
    }
}

extension ArchiveWriteViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        self.images = images
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
 
extension ArchiveWriteViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            pickerView.setSubConstraint(view: self.view)
            pickerView.selectCharactorButton?.addTarget(self, action: #selector(setCharactor), for: .touchDown)
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == 0 {
            if let text = textField.text {
                info.title = text.trimmingCharacters(in: .whitespacesAndNewlines)
                checkButton()
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.tag == 1 {
            return false
        } else {
            return true
        }
    }
}
