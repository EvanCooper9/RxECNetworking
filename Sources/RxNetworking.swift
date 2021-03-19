import ECNetworking
import Foundation
import RxSwift

public protocol RxNetworking {
    func send<T: Request>(_ request: T) -> Single<T.Response>
    func send(_ request: NetworkRequest) -> Single<NetworkResponse>
}

extension Network: RxNetworking {
    public func send<T: Request>(_ request: T) -> Single<T.Response> {
        .create { [weak self] single -> Disposable in
            guard let self = self else { return Disposables.create() }
            let task = self.send(request) { single($0) }
            return self.disposable(with: task)
        }
    }
    
    public func send(_ request: NetworkRequest) -> Single<NetworkResponse> {
        .create { [weak self] single -> Disposable in
            guard let self = self else { return Disposables.create() }
            let task = self.send(request) { single($0) }
            return self.disposable(with: task)
        }
    }
    
    // MARK: - Private Methods
    
    private func disposable(with task: URLSessionTask?) -> Disposable {
        Disposables.create { task?.cancel() }
    }
}
