import UIKit
import Alamofire

class FinishDataManager {
    func patchRate(idx: Int, id: Int) {
        if let url = URL(string: URLString.finishRate), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let body: Parameters = [
                "conceptId":id,
                "conceptPoint": idx+1,
            ]
            AF.request(url, method: .patch, parameters: body, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: FinishRateResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result.message)
                    case .failure(let error):
                        print("rateError: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func patchFinish(time: Int) {
        if let url = URL(string: URLString.finishEnd), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            let body: Parameters = [
                "timer":time
            ]
            AF.request(url, method: .patch, parameters: body, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: FinishEndResponse.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result.message)
                    case .failure(let error):
                        print("patchFinish: \(error.localizedDescription)")
                    }
                }
        }
    }
}
