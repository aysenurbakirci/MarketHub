//
//  PriceFormatterTests.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class PriceFormatterTests: XCTestCase {
    
  var sut: PriceFormatting?

  override func setUp() {
    super.setUp()
    sut = PriceFormatter()
  }
    
  override func tearDown() {
    sut = nil
    super.tearDown()
  }
    
  func testFormat() {
    let formattedPrice = sut?.format(3650.0)
    XCTAssertEqual(formattedPrice, "3650.0 TL")
  }
}
