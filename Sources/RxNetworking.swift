import ECNetworking
import Foundation
import RxSwift

public protocol RxNetwork {
    func send<T: Request>(_ request: T) -> Single<T.Response>
}
