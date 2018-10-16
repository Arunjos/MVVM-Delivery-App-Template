//
//  DeliveryAppTests.swift
//  DeliveryAppTests
//
//  Created by Arun Jose on 21/09/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import XCTest
@testable import DeliveryApp

class DeliveryAppTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testURLEncoding() {
        guard let url = URL(string: "https://mock-api-mobile.dev.lalamove.com/deliveries") else {
            XCTAssertTrue(false, "Could not load url")
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30.00)
        let parameter = ["offset": 1, "limit": 10]
        do{
            try URLParameterEncoding().encode(urlRequest: &urlRequest, parameters: parameter)
            guard let responseURL = urlRequest.url?.absoluteString else{
                XCTAssertTrue(false, "url is nil")
                return
            }
            let expectedOutputURL = "https://mock-api-mobile.dev.lalamove.com/deliveries?offset=1&limit=10"
            XCTAssertEqual(responseURL, expectedOutputURL)
        }catch{
            
        }
    }
    
    func testCaching() {
        let location = [Location(lat: 10.0, lng: 11.0, address: "arun address"), Location(lat: 12.0, lng: 13.0, address: "hiran address")]
        do{
            try JSONArchiveCache().save(object: location)
        } catch{
            XCTFail(error.localizedDescription)
        }
        
        do{
            let retrivedLocation = try JSONArchiveCache().retrive(objectType: [Location].self)
            XCTAssertEqual(location, retrivedLocation)
        }catch{
            XCTFail(error.localizedDescription)
        }
    }
}
