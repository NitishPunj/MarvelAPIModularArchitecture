import XCTest
@testable import Networking

final class NetworkingTests: XCTestCase {
    
    private var sut: NetworkRequestDispatcher!
    private var mockSession: MockURLSession!
    
    
    override func setUp() {
        mockSession = MockURLSession()
        sut = NetworkRequestDispatcher(session: mockSession)
    }
    
    
    func test_execute_mockURLSession_returnsError() {
        let promise = expectation(description: #function)
        
        mockSession.error = error400
        sut.execute(request: .init(url: .init(string: "TestURL")!)) { result in
            
            switch result {
            case .failure(_):
                promise.fulfill()
                
            case.success(_):
                XCTFail("Expected failure")
            }
            
        }
        waitForExpectations(timeout:  0.1)
    }
    
    
    func test_execute_mockURLSession_returnsSuccess200WithData() {
        let promise = expectation(description: #function)
        
        mockSession.data = Data()
        mockSession.response = MockURLSession.httpResponseWithStatusCode(200)
        sut.execute(request: .init(url: .init(string: "TestURL")!)) { result in
            
            switch result {
            case .failure(_):
                XCTFail("Expected success")
            case.success(let data):
                XCTAssertNotNil(data)
                promise.fulfill()
            }
        }
        waitForExpectations(timeout:  0.1)
    }
    
    func test_execute_mockURLSession_returnsfailureWithServerError() {
        let promise = expectation(description: #function)
        
        mockSession.data = Data()
        mockSession.response = MockURLSession.httpResponseWithStatusCode(500)
        sut.execute(request: .init(url: .init(string: "TestURL")!)) { result in
            
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, .serverError)
                promise.fulfill()
            case.success(_):
                XCTFail("Expected failure")
            
            }
        }
        waitForExpectations(timeout:  0.1)
    }
}


private final class MockURLSession: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    var response: URLResponse?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let response = self.response
        return MockURLSessionDataTask {
            completionHandler(data,response,error)
        }
    }
    
    static func httpResponseWithStatusCode(_ statusCode: Int) -> HTTPURLResponse {
        HTTPURLResponse(url: URL(string: "https://Test.com")!,
                        statusCode: statusCode,
                        httpVersion: nil,
                        headerFields: nil)!
    }
}


private final class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}


private var error400: Error {
    NSError(domain: "Mock", code: 400, userInfo: nil)
}

