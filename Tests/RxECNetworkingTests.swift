import ECNetworking
import RxECNetworking
import RxSwift
import XCTest

final class RxECNetworkingTests: XCTestCase {
    
    private enum Error: Swift.Error {
        case any
    }
    
    private var session: MockURLSession!
    private var network: RxNetworking!
    private var url: URL!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        session = MockURLSession()
        url = URL(string: "https://example.com")!
        let configuration = NetworkConfiguration(baseURL: url, logging: false)
        network = Network(configuration: configuration, session: session)
        disposeBag = DisposeBag()
    }
    
    func testThatErrorIsReturned() {
        let expectation = self.expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        
        let request = MockRequest()
        session.error = Error.any
        
        network.send(request)
            .subscribe(onFailure: { error in
                XCTAssertEqual(error as! Error, .any)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        network.send(request.buildRequest(with: url))
            .subscribe(onFailure: { error in
                XCTAssertEqual(error as! Error, .any)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testThatDataIsReturned() {
        let expectation = self.expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        
        let request = MockRequest()
        session.data = Data()
        
        network.send(request)
            .subscribe(onSuccess: { _ in
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        network.send(request.buildRequest(with: url))
            .subscribe(onSuccess: { _ in
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
    }
}
