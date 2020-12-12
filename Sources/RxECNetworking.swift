import ECNetworking
import RxSwift

public protocol RxECNetworking {
    func send<T: Request>(_ request: T) -> Single<T.Response>
    func send(_ request: NetworkRequest) -> Single<NetworkResponse>
}

extension Network: RxECNetworking {
    public func send<T: Request>(_ request: T) -> Single<T.Response> {
        .create { [weak self] single -> Disposable in
            guard let self = self else { return Disposables.create() }
            
            let task = self.send(request) { result in
                self.completion(for: single, with: result)
            }
            
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
    public func send(_ request: NetworkRequest) -> Single<NetworkResponse> {
        .create { [weak self] single -> Disposable in
            guard let self = self else { return Disposables.create() }
            
            let task = self.send(request) { result in
                self.completion(for: single, with: result)
            }
            
            return Disposables.create {
                task?.cancel()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func completion<T>(for single: Single<T>.SingleObserver, with result: Result<T, Error>) {
        switch result {
        case .failure(let error):
            single(.failure(error))
        case .success(let response):
            single(.success(response))
        }
    }
}
