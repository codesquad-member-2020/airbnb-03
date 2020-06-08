import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
    case put = "PUT"
}

protocol Request {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpBody: Data? { get }
    var format: String? { get }
    
    func urlRequest() -> URLRequest?
}

extension Request {
    var httpMethod: HTTPMethod { return .get }
    var httpBody: Data? { return nil }
    var format: String? { return "application/json" }
    
    func urlRequest() -> URLRequest? {
        guard let url = URL(string: path) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = httpBody
        return urlRequest
    }
}
