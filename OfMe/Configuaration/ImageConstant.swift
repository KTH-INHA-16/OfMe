import Foundation

struct ImgName {
    
    private init() {}
    
    enum imgNameType: String {
        case loginLogo = "loginLogo"
        case chevronLeft = "chevron_left"
        case checked = "checked"
        case unchecked = "unchecked"
        case falseCheck = "falseCheck"
        case trueCheck = "trueCheck"
        case homeIcon = "home"
        case questionIcon = "question"
        case myInfoIcon = "myInfo"
        case archiveIcon = "archive"
        case cancel = "cancel"
        case chevronRightWhite = "chevron_right_white"
        case bubble = "bubble"
        case testIcon = "testIcon"
        case normalIcon = "normalIcon"
    }
    
    static func imgName(of imgType: imgNameType) -> String {
        return imgType.rawValue
    }
}
