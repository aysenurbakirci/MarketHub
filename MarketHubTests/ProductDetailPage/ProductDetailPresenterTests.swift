//
//  ProductListPresenterTests.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

class ProductDetailPresenterTests: XCTestCase {
  private var mockView: ProductDetailViewMock!
  private var mockInteractor: ProductDetailInteractorMock!
  private var mockBuilder: ProductDetailViewModelBuilderMock!
  private var mockRouter: ProductDetailRouterMock!
  private var sut: ProductDetailPresenter!
    
  override func setUp() {
    super.setUp()
    mockView = ProductDetailViewMock()
    mockInteractor = ProductDetailInteractorMock()
    mockInteractor.mockResult = .success(ProductDetailMockModels.productDetailModel)
    mockBuilder = ProductDetailViewModelBuilderMock()
    mockRouter = ProductDetailRouterMock()
    sut = ProductDetailPresenter(
      opening: ProductDetailOpening(productId: 12333),
      interactor: mockInteractor,
      builder: mockBuilder,
      router: mockRouter,
      view: mockView
    )
  }

  override func tearDown() {
    mockView = nil
    mockInteractor = nil
    mockBuilder = nil
    mockRouter = nil
    sut = nil
    super.tearDown()
  }

  func testViewDidLoad() {
    sut.viewDidLoad()
    let expectation = XCTestExpectation(description: "Async operation completed")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 5)
    XCTAssertTrue(mockView.showLoadingViewCalled)
    XCTAssertTrue(mockInteractor.fetchProductDetailCalled)
    XCTAssertEqual(mockInteractor.fetchProductDetailId, 12333)
    XCTAssertTrue(mockView.hideLoadingViewCalled)
    XCTAssertTrue(mockView.updateCalled)
    XCTAssertNotNil(mockView.updateData)
  }
}
