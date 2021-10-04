import XCTest
import Networking

@testable import MarvelAPIService

final class MarvelAPIServiceTests: XCTestCase {
    
    var sut: MarvelService!
    private var mockDispatcher: MockDispatcher!
    
    override func setUp() {
        
        mockDispatcher = MockDispatcher()
        sut = .init(dispatcher: mockDispatcher)
    }
    
    
    func test_fetchCharacters_returnsDataDecodesToCharacters() {
        let promise = expectation(description: #function)
        mockDispatcher.data = MockHelper.loadLocalJSON("MockResponse")
        sut.fetchCharacters { result in
            switch result {
            case .success(let chars):
                XCTAssertEqual(chars.count, 25)
                promise.fulfill()

            case .failure(_):
                XCTFail("expected success")
            }
        }
      waitForExpectations(timeout:  0.1)
    }
    
    
    func test_fetchCharacters_returnsErrorInFailure() {
        let promise = expectation(description: #function)
        mockDispatcher.throwError = true
        sut.fetchCharacters { result in
            switch result {
            case .success(_):
                XCTFail("expected failure")
                
                
            case .failure(let error):
                XCTAssertNotNil(error)
                promise.fulfill()
            }
        }
        
        waitForExpectations(timeout:  0.1)
    }
}
