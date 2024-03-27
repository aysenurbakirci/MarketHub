//
//  NetworkOperationTests.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

class NetworkOperationTests: XCTestCase {
  func testNetworkRequest() {
    let network: Network = NetworkMock()
    let request = network.request()

    XCTAssertNotNil(request)
    XCTAssertEqual(request?.httpMethod, network.method.rawValue)
    XCTAssertEqual(request?.url?.scheme, network.schema)
    XCTAssertEqual(request?.url?.host, network.host)
    XCTAssertEqual(request?.url?.path, network.path)
    if let queryItems = request?.url?.query?.components(separatedBy: "&") {
      XCTAssertEqual(queryItems.count, network.queryItems?.count)
    }
  }
    
  func testExecuteRequestSuccess() {
    let network: Network = ProductAPI.productDetail(id: 12333)
    let manager = NetworkManager.shared
        
    let expectation = XCTestExpectation(description: "Network request completion")
    manager.executeRequest(network, completion: { (result: Result<ProductDetailModel, Error>) in
      switch result {
      case .success(let data):
        XCTAssertNotNil(data)
        expectation.fulfill()
      case .failure(let error):
        XCTFail("Error: \(error.localizedDescription)")
        expectation.fulfill()
      }
    })
    wait(for: [expectation], timeout: 5.0)
  }
}
