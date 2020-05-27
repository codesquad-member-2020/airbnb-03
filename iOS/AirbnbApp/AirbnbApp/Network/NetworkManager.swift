import Foundation
import Alamofire

enum NetworkErrorCase {
    case NotFound
    case NetworkError
}

final class NetworkManager {
    static func getResource(from URL: URL,
                               completionHandler: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(URL).responseData { (responseData) in
            switch responseData.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    static func getResource(from urlString: String,
                           completionHandler: @escaping (Result<Data, AFError>) -> Void) {
        let url = URL(string: urlString)!
        AF.request(url).responseData { (response) in
            switch response.result {
            case .success(let data):
                completionHandler(.success(data))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
