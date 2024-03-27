//
//  ProductListViewModel.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 11.01.2024.
//

import UIKit

struct ProductListViewModels {
  let sponsoredProductCells: [ReusableCellViewModel]
  let productCells: [ReusableCellViewModel]
}

struct ProductCellViewModel: ReusableCellViewModel {
  var cell: ReusableCell.Type = ProductCell.self
  let id: Int
  let title: String
  let sellerName: String?
  let imageModel: ProductImageViewModel
  let priceModel: PriceViewModel
  let ratingModel: RatingViewModel?
}

struct SponsoredProductCellViewModel: ReusableCellViewModel {
  var cell: ReusableCell.Type = SponsoredProductCell.self
  let id: Int
  let title: String
  let bannerTitle: String?
  let imageModel: ProductImageViewModel
  let priceModel: PriceViewModel
  let ratingModel: RatingViewModel?
}
