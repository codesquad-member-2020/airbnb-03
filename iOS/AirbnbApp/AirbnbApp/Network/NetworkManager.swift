import Foundation
import Alamofire

enum NetworkErrorCase {
    case NotFound
    case NetworkError
}

final class NetworkManager {
    
    static func getResource<Parameters: Encodable>(
        from url: URL,
        parameters: Parameters? = nil,
        encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
        completionHandler: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url, parameters: parameters, encoder: encoder).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    static func getResource(
        from urlString: String,
        completionHandler: @escaping (Result<Data, AFError>) -> Void) {
        let url = URL(string: urlString)!
        getResource(from: url, completionHandler: completionHandler)
    }

    static func getResource(
        from url: URL,
        completionHandler: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    static func requestSave(
        urlRequest: URLRequest,
        completionHandler: @escaping (_ isSuccessful: Bool) -> Void) {
        AF.request(urlRequest).responseData { (responseData) in
            guard let response = responseData.response
            else {
                completionHandler(false)
                return
            }
            if response.statusCode == 200 {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
}
