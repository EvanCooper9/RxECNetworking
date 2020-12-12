# RxECNetworking

An extension of [ECNetworking](https://github.com/EvanCooper9/ECNetworking).

## Installation
### SPM
```swift
.package(url: "https://github.com/EvanCooper9/RxECNetworking", from: "1.0.0")
```

### Cocoapods
```ruby
pod 'RxECNetworking'
```

## Usage

The only difference is how requests are sent and responses are handled.

```swift
let request = ListUsersRequest(online: true)

network.send(request)
    .subscribe(onSuccess: { users in
        showUsers(users)
    })
    .disposed(by: disposeBag)
``` 
