//
//  AppTesteTests.swift
//  AppTesteTests
//
//  Created by marcel.soares on 25/10/20.
//

import XCTest
@testable import AppTeste

class AppTesteTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    // MARK: SERVICES
    func testGetMovies() {
        var result: Bool?
        let expectation = XCTestExpectation(description: "wait_response")
        ServiceManager().loadMovies() { (errorMessage, moviesResponse) in
            
            if let _ = moviesResponse {
                result = true
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertTrue(result ?? false)
    }
    
    func testGetMovieDetail() {
        var result: Bool?
        let expectation = XCTestExpectation(description: "wait_response")
        ServiceManager().loadMovieDetail(movieId: "1") { (errorMessage, moviesResponse) in
            
            if let _ = moviesResponse {
                result = true
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertTrue(result ?? false)
    }
    
    
    func testBook() {
        
        let parameters: [String: Any] = [
            "movieId": "1",
            "name": "Teste",
            "email": "teste@teste.com"
        ]
        
        var result: Bool?
        let expectation = XCTestExpectation(description: "wait_response")
        ServiceManager().book(parameters: parameters) { (messageError, bookResponse) in
            
            if (messageError == nil)  {
                result = true
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertTrue(result ?? false)
    }
    
    
    func testNilAddress() {
        
        var result: Bool?
        let expectation = XCTestExpectation(description: "wait_response")
        CustomFunctions().getAddressFromLocation(latitude: nil, longitude: nil, completion: { (address) in
            result = true
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertTrue(result ?? false)
    }

    func testInvalidAddress() {
        
        var result: Bool?
        let expectation = XCTestExpectation(description: "wait_response")
        CustomFunctions().getAddressFromLocation(latitude: 0.0, longitude: 0.0, completion: { (address) in
            result = true
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
        
        XCTAssertTrue(result ?? false)
    }
    
    func testInvalidEmail() {
        XCTAssertFalse(CustomFunctions().isValidEmail(email: ""))
    }
    
    func testValidEmail() {
        XCTAssertTrue(CustomFunctions().isValidEmail(email: "teste@teste.com"))
    }
    
}
