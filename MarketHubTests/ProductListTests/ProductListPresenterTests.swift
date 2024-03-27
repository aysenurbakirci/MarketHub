//
//  ProductListPresenterTests.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

class ProductListPresenterTests: XCTestCase {
  private var mockInteractor: ProductListInteractorMock!
  private var mockView: ProductListViewMock!
  private var mockRouter: ProductListRouterMock!
  private var mockBuilder: ProductListViewModelBuilderMock!
    
  private var sut: ProductListPresenter!
    
  override func setUp() {
    super.setUp()
    mockInteractor = ProductListInteractorMock()
    mockView = ProductListViewMock()
    mockRouter = ProductListRouterMock()
    mockBuilder = ProductListViewModelBuilderMock()
        
    sut = ProductListPresenter(
      interactor: mockInteractor,
      view: mockView,
      router: mockRouter,
      builder: mockBuilder
    )
  }

  override func tearDown() {
    sut = nil
    mockInteractor = nil
    mockView = nil
    mockRouter = nil
    mockBuilder = nil
    super.tearDown()
  }
    
  func testFetchListingDataSuccess() {
    mockInteractor.mockResult = .success(ProductListMockModels.productListModel)
    sut.viewDidLoad()
    let expectation = XCTestExpectation(description: "Async operation completed")
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 5)
    XCTAssertTrue(mockView.showLoadingViewCalled)
    XCTAssertTrue(mockInteractor.fetchProductListCalled)
    XCTAssertTrue(mockView.updateCalled)
    XCTAssertTrue(mockView.hideLoadingViewCalled)
  }
    
  func testFetchListingDataFailure() {
    mockInteractor.mockResult = .failure(NSError(domain: "", code: 404))
    sut.viewDidLoad()

    XCTAssertTrue(mockView.showLoadingViewCalled)
    XCTAssertTrue(mockInteractor.fetchProductListCalled)
    XCTAssertFalse(mockView.updateCalled)
  }
    
  func testOnInfiniteScrollReachedEndSuccess() {
    mockInteractor.mockResult = .success(ProductListMockModels.productListModel)
    sut.onInfiniteScrollReachedEnd()
    XCTAssertTrue(mockInteractor.fetchProductListCalled)
    XCTAssertTrue(mockView.finishPaginationLoadingCalled)
    XCTAssertTrue(mockView.updateCalled)
  }
    
  func testOnInfiniteScrollReachedEndFailure() {
    mockInteractor.mockResult = .failure(NSError())
    sut.onInfiniteScrollReachedEnd()

    XCTAssertTrue(mockInteractor.fetchProductListCalled)
    XCTAssertTrue(mockView.finishPaginationLoadingCalled)
  }
    
  func testOpenDetailPage() {
    mockInteractor.mockResult = .success(ProductListMockModels.productListModel)
    sut.viewDidLoad()
    sut.openDetailPage(section: .product, index: 0)

    XCTAssertTrue(mockRouter.openDetailPageCalled)
    XCTAssertEqual(mockRouter.openDetailPageOpening, ProductListMockModels.opening)
  }
}
