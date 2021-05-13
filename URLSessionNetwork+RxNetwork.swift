import ECNetworking
import RxSwift

extension URLSessionNetwork: RxNetwork {
    public func send<T: Request>(_ request: T) -> Single<T.Response> {
        .create { [weak self] single -> Disposable in
            guard let self = self else { return Disposables.create() }
            let task = self.send(request) { single($0) }
            return self.disposable(with: task)
        }
    }
    
    // MARK: - Private Methods
    
    private func disposable(with cancellable: Cancellable?) -> Disposable {
        Disposables.create { cancellable?.cancel() }
    }
}

