//
//  IOSChallengeTests.swift
//  IOSChallengeTests
//
//  Created by Heydon Costello on 17/05/2022.
//

import XCTest
@testable import IOSChallenge

class IOSChallengeTests: XCTestCase {
    
    //put json here to test decoding
    let apiJson = ""

    override func setUpWithError() throws {}

    override func tearDownWithError() throws {}

    func testWhereDataReturnedFromApiIsMissing() async throws {
        var data : IOSChallenge.PlanetApiResult?
        
        data = await IOSChallenge.getData(URL(string: "https://www.test.com")!, session: MockURLSession())
        
        XCTAssert(data == nil)
    }

    class MockURLSession: URLSessionProtocol {
        var nextDataTask = MockURLSessionDataTask()
        private var lastURL: URL?
        
        func dataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            lastURL = with
            completionHandler(nil, nil, nil)
            return URLSessionDataTask();
        }
        
        
    }
    
    class MockURLSessionDataTask: IOSChallenge.URLSessionDataTaskProtocol {
        private (set) var resumeWasCalled = false

        func resume() {
            resumeWasCalled = true
        }
    }



}
