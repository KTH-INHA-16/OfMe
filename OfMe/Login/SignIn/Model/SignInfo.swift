import Foundation


class SignInfo {
    var email: String
    var password2: String
    var password: String
    var nickName: String
    var check: Bool
    var emailCheck: Bool
    var passwordCheck: Bool
    var passwordVerifyCheck: Bool
    var nickNameCheck: Bool
    
    init() {
        email = ""
        password = ""
        nickName = ""
        password2 = password
        check = false
        emailCheck = true
        passwordCheck = true
        passwordVerifyCheck = true
        nickNameCheck = true
    }
    
    func setUp() {
        emailCheck = true
        passwordCheck = true
        passwordVerifyCheck = true
        nickNameCheck = true
    }
}
