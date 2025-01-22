import UIKit


protocol NetworkServiceProtocols {
    
    func fetchData<T: Codable>(url: URL,
                               httpMethod: HTTPMethod,
                               body: Encodable?,
                               headers: [String: String]?,
                               completion: @escaping(Result<T, NetworkError>)
                               -> Void  )
}

