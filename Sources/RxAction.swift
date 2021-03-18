import ECNetworking
import Foundation
import RxSwift

public protocol RxAction: Action {}

public protocol RxRequestWillBeginAction: RxAction, RequestWillBeginAction {
    var disposeBag: DisposeBag { get }
    func requestWillBegin(_ request: NetworkRequest) -> Single<NetworkRequest>
}

extension RxRequestWillBeginAction {
    public func requestWillBegin(_ request: NetworkRequest, completion: @escaping (Result<NetworkRequest, Error>) -> Void) {
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
    func responseReceived(request: NetworkRequest, response: NetworkResponse) -> Single<NetworkResponse>
}

extension RxResponseCompletedAction {
    public func responseReceived(request: NetworkRequest, response: NetworkResponse, completion: @escaping (Result<NetworkResponse, Error>) -> Void) {
        responseReceived(request: request, response: response)
            .subscribe { response in
                completion(.success(response))
            } onFailure: { error in
                completion(.failure(error))
            }
            .disposed(by: disposeBag)
    }
}

struct TestRxAction {
    let disposeBag = DisposeBag()
}

extension TestRxAction: RxRequestWillBeginAction {
    func requestWillBegin(_ request: NetworkRequest) -> Single<NetworkRequest> {
        .just(request)
    }
}

extension TestRxAction: RxRequestBeganAction {
    func requestBegan(_ request: URLRequest) {
        print(#function)
    }
}

extension TestRxAction: RxResponseBeganAction {
    func responseBegan(request: NetworkRequest, response: HTTPURLResponse) {
        print(#function)
    }
}

extension TestRxAction: RxResponseCompletedAction {
    func responseReceived(request: NetworkRequest, response: NetworkResponse) -> Single<NetworkResponse> {
        .just(response)
    }
}
