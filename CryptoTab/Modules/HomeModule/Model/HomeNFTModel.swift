import UIKit

struct HomeNFTsModel: Hashable {
    let identifier: UUID = UUID()
    let collection: String
    let name: String
    let description: String?
    let imageURL: String?
    let owner: String
    let safelistStatus: String?
    let category: String?
    let openseaURL: String?
    let contracts: [Contract]?

    struct Contract: Codable, Hashable {
        let address: String
        let chain: String
    }

    // ✅ Добавляем `hash(into:)`
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    // ✅ Добавляем сравнение
    static func == (lhs: HomeNFTsModel, rhs: HomeNFTsModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
