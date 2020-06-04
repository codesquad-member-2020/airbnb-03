import UIKit

struct StayDetailUseCase {
    static func getStayDetail(
        url: URL,
        completionHandler: @escaping (Result<StayDetail, Error>) -> Void) {
        NetworkManager.getResource(from: url) { (result) in
            switch result {
            case .success(let data):
                if let decoded = try? JSONDecoder().decode(StayDetail.self, from: data) {
                    debugPrint("Decoding StayDetail is success.")
                    debugPrint(decoded)
                    completionHandler(.success(decoded))
                } else {
                    debugPrint("Decoding StayDetail is failed.")
                }
            case .failure(let error):
                debugPrint(error)
                completionHandler(.failure(error))
            }
        }
    }

    static func getImage(from urlString: String, completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        NetworkManager.getResource(from: urlString) { result in
            switch result {
            case .success(let data):
                if let decoded = UIImage(data: data) {
                    completionHandler(.success(decoded))
                } else {
                    debugPrint("Decoding UIImage is failed.")
                }
            case .failure(let error):
                debugPrint(error)
                completionHandler(.failure(error))
            }
        }
    }
}

