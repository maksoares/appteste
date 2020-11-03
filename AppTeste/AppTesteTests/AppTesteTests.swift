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
    
    func testInitParse() {
        
        let json = AppTesteDataGenerator.getMovieJson()
        
        if let model = try? JSONDecoder().decode(Movie.self, from: json.rawData()) {
            
            let expectedId = "1"
            let expectedTitle = "ROCKY: UM LUTADOR"
            let expectedDate = 218426520.0
            let expectedSynopsis = "Rocky Balboa, um pequeno boxeador da classe trabalhadora da Filadélfia, é arbitrariamente escolhido para lutar contra o campeão dos pesos pesados, Apollo Creed, quando o adversário do invicto lutador agendado para a luta é ferido. Durante o treinamento com o mal-humorado Mickey Goldmill, Rocky timidamente começa um relacionamento com Adrian, a invisível irmã de Paulie, seu amigo empacotador de carne."
            let expectedImage = "https://limaomecanico.com.br/wp-content/uploads/2019/11/Rocky-Um-Lutador.jpg"
            let expectedTime = 218426520.0
            let expectedPrice = 1.99
            
            //People
            let expectedPersonId = "1"
            let expectedName = "Sylvester Stallone\n(Rocky)"
            let expectedPicture = "https://rollingstone.uol.com.br/media/_versions/sylvester_stallone_como_rocky_foto__metro-goldwyn-mayer_studios_inc___reproducao_via_imdb_widelg.jpg"
            

            XCTAssertEqual(model.movieId, expectedId)
            XCTAssertEqual(model.title, expectedTitle)
            XCTAssertEqual(model.date, expectedDate)
            XCTAssertEqual(model.synopsis, expectedSynopsis)
            XCTAssertEqual(model.image, expectedImage)
            XCTAssertEqual(model.time, expectedTime)
            XCTAssertEqual(model.price!, expectedPrice, accuracy: 0.001)
            
            //People
            XCTAssertNotNil(model.people?.first)
            let people = model.people!.first!
            XCTAssertEqual(people.personId, expectedPersonId)
            XCTAssertEqual(people.name, expectedName)
            XCTAssertEqual(people.picture, expectedPicture)
            
        }else{
            XCTAssert(false)
        }

    }

    
}




