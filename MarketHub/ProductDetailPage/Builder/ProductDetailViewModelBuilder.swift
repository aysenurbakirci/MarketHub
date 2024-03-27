//
//  ProductDetailViewModelBuilder.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 13.01.2024.
//

import Foundation

protocol ProductDetailViewModelBuilding {
  func buildDataSource(with viewModel: ProductDetailModel) -> ProductDetailViewModels
}

final class ProductDetailViewModelBuilder: ProductDetailViewModelBuilding {
  private let priceFormatter: PriceFormatting

  init(priceFormatter: PriceFormatting) {
    self.priceFormatter = priceFormatter
  }

  func buildDataSource(with viewModel: ProductDetailModel) -> ProductDetailViewModels {
    var cellModels: [ReusableCellViewModel] = []
    let imageModels = viewModel.images.map { url in
      ProductImageViewModel(imageUrlString: url, placeholderImage: .productPlaceholder)
    }
    let images = ImageSliderViewModel(imageViewModels: imageModels)
    cellModels.append(images)
        
    let info = ProductInformationViewModel(
      title: viewModel.title,
      description: viewModel.description
    )
    cellModels.append(info)
      
    if let rate = viewModel.rate {
      let ratingInfo = ProductRatingInformationViewModel(
        ratingModel: createRatingModel(averageRating: rate)
      )
      cellModels.append(ratingInfo)
    }

    let priceInfo = ProductPriceInformationViewModel(
      discountPercent: calcPrecent(price: viewModel.price, discountPrice: viewModel.instantDiscountPrice),
      priceModel: createPriceModel(price: viewModel.price, discountPrice: viewModel.instantDiscountPrice)
    )
    cellModels.append(priceInfo)

    return ProductDetailViewModels(cellViewModels: cellModels)
  }
    
  private func createPriceModel(price: Float, discountPrice: Float?) -> PriceViewModel {
    let model = PriceViewModel(
      price: (discountPrice != nil) ? priceFormatter.format(price) : nil,
      salePrice: priceFormatter.format(discountPrice ?? price)
    )
    return model
  }
    
  private func calcPrecent(price: Float, discountPrice: Float?) -> String? {
    guard let discountPrice = discountPrice else { return nil }
    let percent =  (1 - (discountPrice / price)) * 100
    return "%\(Int(ceil(percent)))"
  }
    
  private func createRatingModel(averageRating: Float?) -> RatingViewModel? {
    guard let rating = averageRating else { return nil }
    return RatingViewModel(rating: rating)
  }
}
