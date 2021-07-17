import UIKit
import Alamofire

class ConceptResultDataManager {
    func registerConcept() {
        if let url = URL(string: URLString.conccept), let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            var body: Parameters = [:]
            if let id = UserDefaults.standard.object(forKey: "conceptID") as? Int {
                body = ["conceptId": id]
            } else {
                let value = Int.random(in: 1...17)
                UserDefaults.standard.setValue(value, forKey: "conceptID")
                body = ["conceptId": value]
            }
            AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header)
                .validate()
                .responseDecodable(of: ConceptRegister.self) { response in
                    switch response.result {
                    case .success(let result):
                        print(result)
                    case .failure(let error):
                        print("register Error: \(error.localizedDescription)")
                    }
                }
        }
    }
    
    func getConceptResult(completed: @escaping (_ result: [ConceptResult]) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String,
           let id = UserDefaults.standard.object(forKey: "conceptID") as? Int {
            let header: HTTPHeaders = ["x-access-token":jwt]
            if let url = URL(string: URLString.conccept+"/\(id)") {
                AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                    .validate()
                    .responseDecodable(of: ConceptResultResponse.self) { response in
                        switch response.result {
                        case .success(let result):
                            if let res = result.result {
                                completed(res)
                            } else {
                                completed([])
                            }
                        case .failure(let error):
                            completed([])
                            print("conceptResult Error: \(error.localizedDescription)")
                        }
                    }
            }
        }
    }
    
    func getConceptResult(idx: Int, completed: @escaping (_ result: [ConceptResult]) -> Void) {
        if let jwt = UserDefaults.standard.object(forKey: "jwt") as? String {
            let header: HTTPHeaders = ["x-access-token":jwt]
            if let url = URL(string: URLString.conccept+"/\(idx)") {
                AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header)
                    .validate()
                    .responseDecodable(of: ConceptResultResponse.self) { response in
                        switch response.result {
                        case .success(let result):
                            if let res = result.result {
                                completed(res)
                            } else {
                                completed([])
                            }
                        case .failure(let error):
                            completed([])
                            print("conceptResult Error: \(error.localizedDescription)")
                        }
                    }
            }
        }
    }
}
