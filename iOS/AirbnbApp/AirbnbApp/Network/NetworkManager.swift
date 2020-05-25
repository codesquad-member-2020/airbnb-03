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
}
