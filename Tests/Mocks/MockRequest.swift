import ECNetworking
import Foundation

struct MockRequest: Request {
    func buildRequest(with baseURL: URL) -> NetworkRequest {
        .init(method: .get, url: baseURL)
    }
}
