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
        case chevronRightMainBlue = "chevron_right_mainBlue"
        case bubble = "bubble"
        case testIcon = "testIcon"
        case normalIcon = "normalIcon"
        case moon = "moon"
        case play = "play"
        case pause = "pause"
        case info = "info"
    }
    
    static func imgName(of imgType: imgNameType) -> String {
        return imgType.rawValue
    }
}
