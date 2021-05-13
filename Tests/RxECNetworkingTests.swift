import ECNetworking
import RxECNetworking
import RxSwift
import XCTest

final class URLSessionNetworkTests: XCTestCase {
    
    private enum Error: Swift.Error {
        case any
    }
    
    private var session: MockURLSession!
    private var network: RxNetwork!
    private var url: URL!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        session = MockURLSession()
        url = URL(string: "https://example.com")!
        let configuration = NetworkConfiguration(baseURL: url, logging: false)
        network = URLSessionNetwork(configuration: configuration, session: session)
        disposeBag = DisposeBag()
    }
    
    func testThatErrorIsReturned() {
        let expectation = self.expectation(description: #function)
        
        let request = MockRequest()
        session.error = Error.any
        
        network.send(request)
            .subscribe(onFailure: { error in
                XCTAssertEqual(error as! Error, .any)
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testThatDataIsReturned() {
        let expectation = self.expectation(description: #function)
        
        let request = MockRequest()
        session.data = Data()
        
        network.send(request)
            .subscribe(onSuccess: { _ in
                expectation.fulfill()
            })
            .disposed(by: disposeBag)
        
        wait(for: [expectation], timeout: 1)
    }
}
