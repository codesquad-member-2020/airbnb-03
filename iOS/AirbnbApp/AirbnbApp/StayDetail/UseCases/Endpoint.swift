import Foundation

enum Endpoint {
    static let host = "http://52.79.67.245"

    case detail(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .detail(let id):
            return Self.makeForEndpoint("properties/\(id)")
        }
    }

    private static func makeForEndpoint(_ endpoint: String) -> URL {
        let string = [host, endpoint].joined(separator: "/")
        return URL(string: string)!
    }
}
