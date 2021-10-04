//
//  CharacterViewModelTests.swift
//  MarvelAPITests
//
//  Created by Sharma, Nitish X on 04/10/2021.
//

import XCTest
import MarvelAPIService
@testable import MarvelAPI


final class CharacterViewModelTests: XCTestCase {
    
    private var sut: CharactersViewModel!
    private var mockService: MockService!
    

    override func setUp() {
        super.setUp()
        
        mockService = MockService()
        sut = CharactersViewModel(service: mockService)
        
    }
    
    override func tearDown() {
        
        sut = nil
        mockService = nil
        super.tearDown()
    }
    
    
    func test_fetchData_successWithNoError() {
        let promise = expectation(description: #function)
        
        sut.fetchData { error in
            XCTAssertNil(error)
            promise.fulfill()
        }
        
        waitForExpectations(timeout:  0.1)
    }
    
    func test_fetchData_failureWithError() {
        let promise = expectation(description: #function)
        mockService.throwError = true
        
        sut.fetchData { error in
            XCTAssertNotNil(error)
            promise.fulfill()
        }
        
        waitForExpectations(timeout:  0.1)
    }
}

private final class MockService: MarvelAPIServicing {
    
    var throwError = false
    func fetchCharacters(completion: @escaping (Result<[MarvelCharacter], Error>) -> Void) {
        throwError ? completion( .failure(MockError.fake)) : completion(.success([]))
    }
}

enum MockError: Error {
    case fake
}
