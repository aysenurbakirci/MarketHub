//
//  ImageLoaderTests.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

class ImageLoaderTests: XCTestCase {
  func testLoadImage() {
    let imageLoader = ImageLoader.shared

    let expectation = XCTestExpectation(description: "Image loading expectation")
    let urlString = "https://example.com/image.jpg"

    imageLoader.loadImage(from: urlString, placeholder: .productPlaceholder) { image in
      XCTAssertEqual(image, .productPlaceholder)
      imageLoader.loadImage(from: urlString, placeholder: .productPlaceholder) { cachedImage in
        XCTAssertNotNil(cachedImage)
        expectation.fulfill()
      }
    }
    wait(for: [expectation], timeout: 5.0)
  }
}
