struct Constant {
    static let firstNoti = "isFirstLogin"
}

struct BaseURL {
    // MARK: Image Base
    static let resourceBase: String = "http://sbau.egg-buster.shop"
    static let imgBase: String = "http://sbau.egg-buster.shop"
    static let resource: String = "http://sbau.egg-buster.shop/resources"

    // MARK: BASE URL
    static let base: String = "http://sbau.egg-buster.shop/app"
    
    // MARK : NAVER 지도
    static let naverMap: String = "nmap://place?"
    
    //MARK: Google 지도
    static let googleMap: String = "https://www.google.com/maps/search/"
    
    // MARK: MyInfo 부분 URL
    static let setAlarm: String = "\(base)/fcms/alarm"
    static let fcm: String = "\(base)/fcms"
    static let certification: String = "\(base)/certifications"
    static let certificationCheck: String = "\(base)/certifications/check"
    static let user: String = "\(base)/users"
    static let uesrLogin: String = "\(base)/users/login"
    static let autoLogin: String = "\(base)/views"
    static let signIn: String = "\(base)/users"
    static let getUserInfo: String = "\(base)/users/"
    static let findID: String = "\(base)/users/id-find"
    static let findPassword: String = "\(base)/users/password-find"
    static let noticeList: String = "\(base)/notices"
    static let newsList: String = "\(base)/news"
    static let interestList:String = "\(base)/user-like-contents"
    static let viewList: String = "\(base)/user-qrcode-views"
    static let alarm:String = "\(base)/alarms"
    
    struct ChangePW {
        static let base: String = "\(BaseURL.base)/users/"
        static let pw : String = "/password"
    }
    
    struct ChangeProfile {
        static let base: String = "\(BaseURL.base)/users/"
        static let profileImg: String = "/profileImg"
    }
    
    //MARK: Main 부분 URL
    static let banners: String = "\(base)/banners"
    
    //MARK: Online 부분 URL
    static let onlineContent:String = "\(base)/contents"
    struct GetComment{
        static let base: String = "\(BaseURL.onlineContent)/"
        static let comment: String = "/comments"
        static let report: String = "/report"
    }
    
    //MARK: 온/오프라인 좋아요 URL
    static let likeContent: String = "\(base)/user-like-contents"
    
    //MARK: Offline 부분 URL
    static let offlineAllCategory: String = "\(base)/offline-categories"
    static let offlineCategory: String = "\(base)/offline-categories/"
    static let offlineContent: String = "\(base)/offline-contents/"
    static let offlineDate:String = "\(base)/categories/date"
    static let offlineMap: String = "\(base)/categories/place"
    
    //MARK: Archive 부분 URL
    static let archiveSearch: String = "\(base)/archives"
    
    //MARK: Content 부분 URL
    static let allCategory: String = "\(base)/categories"
    static let content:String = "\(base)/contents"
}

struct ImageName {
    static let square = "square"
    static let checkMark = "checkmark.square.fill"
}
