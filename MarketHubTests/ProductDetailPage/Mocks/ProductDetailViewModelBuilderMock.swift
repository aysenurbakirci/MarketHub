//
//  ProductDetailViewModelBuilderMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductDetailViewModelBuilderMock: ProductDetailViewModelBuilding {
  var buildDataSourceCalled = false
  var buildDataSourceModel: ProductDetailModel?
  var buildDataSourceReturnValue: ProductDetailViewModels?

  func buildDataSource(with viewModel: ProductDetailModel) -> ProductDetailViewModels {
    buildDataSourceCalled = true
    buildDataSourceModel = viewModel
    return buildDataSourceReturnValue ?? ProductDetailViewModels(cellViewModels: [])
  }
}
