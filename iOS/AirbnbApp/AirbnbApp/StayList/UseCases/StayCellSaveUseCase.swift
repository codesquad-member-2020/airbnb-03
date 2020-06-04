import Foundation

struct SavingStayUseCase {
    struct SaveRequest: Request {
        var path: String = Endpoints.save
        var httpMethod: HTTPMethod = .put
        
        init(id: Int) {
            self.path = "\(path)/\(id)"
        }
    }
    
    struct CancelRequest: Request {
        var path: String = Endpoints.save
        var httpMethod: HTTPMethod = .delete
        
        init(id: Int) {
            self.path = "\(path)/\(id)"
        }
    }
    
    /// 숙소 저장 요청 메소드
    /// - Parameters:
    ///   - stayID: 숙소 id
    ///   - shouldCancel: true이면 cancel 요청, false이면 save 요청
    ///   - completionHandler: 결과 처리 handler
    static func requestSave(
        stayID: Int,
        shouldCancel: Bool,
        completionHandler: @escaping (Result<Bool, Error>) -> Void) {
        
        let request: Request = shouldCancel ? CancelRequest(id: stayID) : SaveRequest(id: stayID)
        guard let urlRequest = request.urlRequest()
        else {
            return
        }
        NetworkManager.requestSave(
        urlRequest: urlRequest) { (result) in
            switch result {
            case .success(let isSuccessful):
                completionHandler(.success(isSuccessful))
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
