//
//  ProductDetailViewModelBuilderTests.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

class ProductDetailViewModelBuilderTests: XCTestCase {
  var builder: ProductDetailViewModelBuilder!
  var priceFormatter: PriceFormatterMock!

  override func setUp() {
    super.setUp()
    priceFormatter = PriceFormatterMock()
    builder = ProductDetailViewModelBuilder(priceFormatter: priceFormatter)
  }

  override func tearDown() {
    builder = nil
    priceFormatter = nil
    super.tearDown()
  }

  func testBuildDataSource() {
    let mockModel = ProductDetailMockModels.productDetailModel
    priceFormatter.formatPriceReturnValue = "100TL"
    let result = builder.buildDataSource(with: ProductDetailMockModels.productDetailModel)

    XCTAssertEqual(result.cellViewModels.count, 4)

    XCTAssertTrue(result.cellViewModels[0] is ImageSliderViewModel)
    let imageSliderViewModel = result.cellViewModels[0] as! ImageSliderViewModel
    XCTAssertEqual(imageSliderViewModel.imageViewModels.count, mockModel.images.count)

    XCTAssertTrue(result.cellViewModels[1] is ProductInformationViewModel)
    let infoViewModel = result.cellViewModels[1] as! ProductInformationViewModel
    XCTAssertEqual(infoViewModel.title, mockModel.title)
    XCTAssertEqual(infoViewModel.description, mockModel.description)

    XCTAssertTrue(result.cellViewModels[2] is ProductRatingInformationViewModel)
    let ratingInfoViewModel = result.cellViewModels[2] as! ProductRatingInformationViewModel
    XCTAssertNotNil(ratingInfoViewModel.ratingModel)
    XCTAssertEqual(ratingInfoViewModel.ratingModel?.rating, mockModel.rate)

    XCTAssertTrue(result.cellViewModels[3] is ProductPriceInformationViewModel)
    let priceInfoViewModel = result.cellViewModels[3] as! ProductPriceInformationViewModel
    XCTAssertEqual(priceInfoViewModel.discountPercent, "%20")
    XCTAssertEqual(priceInfoViewModel.priceModel.price, "100TL")
  }
}

