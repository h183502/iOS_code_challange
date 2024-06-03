//
//  ComicTest.swift
//  comics_shortcut
//
//  Created by Heine Fjeldberg on 29/05/2024.
//

import XCTest
@testable import comics_shortcut

final class ComicTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testFetchLatestComic() {
        let comic = epectation(description("Fetching lates comic"))
        let session: URLSession = URLSession(configuration: .default)
        let url = URL(string: "https://xkcd.com/info.0.json")
        guard let customUrl = url else { return }
        
        session.dataTask(with: customUrl) { data, response, error in
            XCTAssertNotNil(data)
            comic.fulfill()
            
        }.resume()
        waitForExpectations(timeout: 5.0) {(error) in
            print(error?.localizedDescription ?? "error")
        }
    }

}
