//
//  NetworkService.swift
//  CryptoTab
//
//  Created by apple on 22.08.2024.
//

import Foundation


final class NetworkService: NetworkServiceProtocols {
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let session = URLSession(configuration: .default)
    
    func fetchData<T>(url: URL,
                      httpMethod: HTTPMethod,
                      body: (any Encodable)?,
                      headers: [String : String]?,
                      completion: @escaping (Result<T, NetworkError>)
                      -> Void) where T : Decodable, T : Encodable {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if let body = body {
            do {
                request.httpBody = try encoder.encode(body)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            } catch {
                completion(.failure(NetworkError.badEncode))
            }
        }
        headers?.forEach{ key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil  else {
                return completion(.failure(NetworkError.badData))
            }
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.badResponse))
            }
            
            switch response.statusCode {
            case 200...299:
                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(.badDecode))
                }
            case 400:
                completion(.failure(.badRequest))
            default:
                completion(.failure(.unknown("Дефолтная ошибка")))
            }
        }
        .resume()
    }
    
    
}
