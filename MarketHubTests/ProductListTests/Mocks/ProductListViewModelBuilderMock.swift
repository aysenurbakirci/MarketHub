//
//  ProductListViewModelBuilderMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductListViewModelBuilderMock: ProductListViewModelBuilding {
  var buildViewModelsCalled = false
  var buildViewModelsInput: ProductListModel?
  var buildViewModelsReturnValue: ProductListViewModels = ProductListViewModels(
    sponsoredProductCells: [],
    productCells: []
  )

  func buildViewModels(viewModel: ProductListModel?) -> ProductListViewModels {
    buildViewModelsCalled = true
    buildViewModelsInput = viewModel
    return buildViewModelsReturnValue
  }
}
