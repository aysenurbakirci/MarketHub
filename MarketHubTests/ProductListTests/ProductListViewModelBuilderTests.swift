//
//  ProductListViewModelBuilderTests.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductListViewModelBuilderTests: XCTestCase {
  private var mockFormatter: PriceFormatterMock!
  private var sut: ProductListViewModelBuilder!

  override func setUp() {
    super.setUp()
    mockFormatter = PriceFormatterMock()
    sut = ProductListViewModelBuilder(priceFormatter: mockFormatter)
  }
    
  override func tearDown() {
    sut = nil
    mockFormatter = nil
    super.tearDown()
  }

  func testBuildViewModels() {
    let mockPriceFormatter = PriceFormatterMock()
    let builder = ProductListViewModelBuilder(priceFormatter: mockPriceFormatter)
    let result = builder.buildViewModels(viewModel: ProductListMockModels.productListModel)

    XCTAssertEqual(result.sponsoredProductCells.count, 1)
    XCTAssertEqual(result.productCells.count, 2)


    if let sponsoredProductViewModel = result.sponsoredProductCells.first as? SponsoredProductCellViewModel {
      XCTAssertEqual(sponsoredProductViewModel.title, "Sponsored Product 1")
      XCTAssertEqual(sponsoredProductViewModel.bannerTitle, Translations.sponsored.rawValue)
      XCTAssertEqual(sponsoredProductViewModel.imageModel.imageUrlString, "image3.jpg")
      XCTAssertEqual(sponsoredProductViewModel.priceModel.price, "Formatted Price")
      XCTAssertEqual(sponsoredProductViewModel.ratingModel?.rating, 3.4)
    } else {
      XCTFail("Failed to cast sponsored product view model")
    }

    if let productViewModel1 = result.productCells[safe: 0] as? ProductCellViewModel {
      XCTAssertEqual(productViewModel1.title, "Product 1")
      XCTAssertEqual(productViewModel1.sellerName, "Seller")
      XCTAssertEqual(productViewModel1.imageModel.imageUrlString, "image1.jpg")
      XCTAssertEqual(productViewModel1.priceModel.price, "Formatted Price")
      XCTAssertEqual(productViewModel1.ratingModel?.rating, 2.1)
    } else {
      XCTFail("Failed to cast product view model 1")
    }

    if let productViewModel2 = result.productCells[safe: 1] as? ProductCellViewModel {
      XCTAssertEqual(productViewModel2.title, "Product 2")
      XCTAssertEqual(productViewModel2.sellerName, "Seller")
      XCTAssertEqual(productViewModel2.imageModel.imageUrlString, "image2.jpg")
      XCTAssertEqual(productViewModel2.priceModel.price, "Formatted Price")
      XCTAssertEqual(productViewModel2.ratingModel?.rating, 4.7)
    } else {
      XCTFail("Failed to cast product view model 2")
    }
    XCTAssertTrue(mockPriceFormatter.formatPriceCalled)
  }
}
