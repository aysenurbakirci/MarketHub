//
//  RatingViewModelTests,.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

class RatingViewModelTests: XCTestCase {
  func testCreateStarTypes() {
    let viewModel = RatingViewModel(rating: 3.5)
    let expectedStarTypes: [StarType] = [.filled, .filled, .filled, .half, .empty]
    XCTAssertEqual(viewModel.starTypes, expectedStarTypes)
  }
}
