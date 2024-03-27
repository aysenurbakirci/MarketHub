//
//  ProductDetailViewModels.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 12.01.2024.
//

import Foundation

struct ProductDetailViewModels {
  let cellViewModels: [ReusableCellViewModel]
}

struct ImageSliderViewModel: ReusableCellViewModel {
  var cell: ReusableCell.Type = ImageSliderCell.self
    
  let imageViewModels: [ProductImageViewModel]
}

struct ProductInformationViewModel: ReusableCellViewModel {
  var cell: ReusableCell.Type = ProductInformationCell.self
    
  let title: String
  let description: String
}

struct ProductRatingInformationViewModel: ReusableCellViewModel {
  var cell: ReusableCell.Type = ProductRatingInformationCell.self

  let ratingModel: RatingViewModel?
}

struct ProductPriceInformationViewModel: ReusableCellViewModel {
  var cell: ReusableCell.Type = ProductPriceInformationCell.self

  let discountPercent: String?
  let priceModel: PriceViewModel
}
