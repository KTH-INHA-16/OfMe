import Foundation

struct CharacterActionResponse: Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [CharacterAction]?
    
    static let error: [CharacterAction] = []
}

struct CharacterAction: Codable {
    var ActionName: String
    var ActionImg: String
}
