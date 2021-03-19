import ECNetworking
import Foundation
import RxSwift

public protocol RxAction: Action {}

public protocol RxRequestWillBeginAction: RxAction, RequestWillBeginAction {
    var disposeBag: DisposeBag { get }
    func requestWillBegin(_ request: NetworkRequest) -> Single<NetworkRequest>
}

public extension RxRequestWillBeginAction {
    func requestWillBegin(_ request: NetworkRequest, completion: @escaping (Result<NetworkRequest, Error>) -> Void) {
        requestWillBegin(request)
            .subscribe { request in
                completion(.success(request))
            } onFailure: { error in
                completion(.failure(error))
            }
            .disposed(by: disposeBag)
    }
}

public protocol RxRequestBeganAction: RxAction, RequestBeganAction {}

public protocol RxResponseBeganAction: RxAction, ResponseBeganAction {}

public protocol RxResponseCompletedAction: RxAction, ResponseCompletedAction {
    var disposeBag: DisposeBag { get }
    
    func responseCompleted(request: NetworkRequest, response: NetworkResponse) -> Single<NetworkResponse>
}

public extension RxResponseCompletedAction {
    func responseCompleted(request: NetworkRequest, response: NetworkResponse, completion: @escaping (Result<NetworkResponse, Error>) -> Void) {
        responseCompleted(request: request, response: response)
            .subscribe { response in
                completion(.success(response))
            } onFailure: { error in
                completion(.failure(error))
            }
            .disposed(by: disposeBag)
    }
}
