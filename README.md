# RxNetworking

An extension of [ECNetworking](https://github.com/EvanCooper9/ECNetworking).

## Installation

### SPM
```swift
.package(url: "https://github.com/EvanCooper9/RxECNetworking", from: "2.0.0")
```

## Usage

### Sending Requests

Sending requests is reactive. Only the syntax is changed.

```swift
let request = ListUsersRequest(online: true)

network.send(request)
    .subscribe(onSuccess: { users in
        showUsers(users)
    })
    .disposed(by: disposeBag)
```

### Actions

Actions are also reactive, all action protocols gain an `Rx` prefix, and require a  `DisposeBag`.

```swift
struct AuthenticationAction: RxRequestWillBeginAction {
    
    let disposeBag = DisposeBag()

    func requestWillBegin(_ request: NetworkRequest) -> Single<NetworkRequest>
        guard request.requiresAuthentication else { .just(request) }
        // add authentication headers
        return .just(request)
    }
}
```
