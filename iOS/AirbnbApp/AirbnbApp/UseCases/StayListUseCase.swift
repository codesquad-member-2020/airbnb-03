import Foundation

struct StayListUseCase {
    static let path: String = "http://3.34.93.158/alex/properties/"
    
    static func getStayList(searchFilterQuery: SearchFilterQuery,
                            completionHandler: @escaping (Result<[Stay], Error>) -> Void) {
        let url = URL(string: path)!
        NetworkManager.getResource(from: url,
                                   parameters: searchFilterQuery) { (result) in
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
