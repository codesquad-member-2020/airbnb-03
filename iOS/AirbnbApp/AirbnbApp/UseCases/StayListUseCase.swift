import Foundation

final class StayListUseCase {
    static let path: String = "https://551ca9ec-85b7-433b-b292-6fad22509ac8.mock.pstmn.io/main"
    
    static func getStayList(completionHandler: @escaping (Result<[Stay], Error>) -> Void) {
        let url = URL(string: path)!
        NetworkManager.getResource(from: url) { (result) in
            switch result {
            case .success(let data):
                guard let decodedData = try? JSONDecoder().decode([Stay].self, from: data) else { return }
                completionHandler(.success(decodedData))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
