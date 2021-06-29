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
    }
    
    static func imgName(of imgType: imgNameType) -> String {
        return imgType.rawValue
    }
}
