//
//  ProductListViewModelBuilder.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 13.01.2024.
//

import Foundation

protocol ProductListViewModelBuilding {
  func buildViewModels(viewModel: ProductListModel?) -> ProductListViewModels
}

final class ProductListViewModelBuilder: ProductListViewModelBuilding {
  private let priceFormatter: PriceFormatting

  init(priceFormatter: PriceFormatting) {
    self.priceFormatter = priceFormatter
  }
    
  func buildViewModels(viewModel: ProductListModel?) -> ProductListViewModels {
    let sponsoredProducts = createSponsoredProducts(viewModels: viewModel?.sponsoredProducts)
    let products = createProducts(viewModels: viewModel?.products)
    return ProductListViewModels(
      sponsoredProductCells: sponsoredProducts,
      productCells: products
    )
  }
    
  private func createSponsoredProducts(viewModels: [ProductModel]?) -> [ReusableCellViewModel] {
    var sponsoredProductViewModels: [ReusableCellViewModel] = []
    viewModels?.forEach({ product in
      let sponsoredProductViewModel = SponsoredProductCellViewModel(
        id: product.id, 
        title: product.title,
        bannerTitle: Translations.sponsored.rawValue,
        imageModel: createImageModel(imageUrlString: product.image),
        priceModel: createPriceModel(price: product.price, discountPrice: product.instantDiscountPrice),
        ratingModel: createRatingModel(averageRating: product.rate)
      )
      sponsoredProductViewModels.append(sponsoredProductViewModel)
    })
    return sponsoredProductViewModels
  }
    
  private func createProducts(viewModels: [ProductModel]?) -> [ReusableCellViewModel] {
    var productViewModels: [ReusableCellViewModel] = []
    viewModels?.forEach({ product in
      let sponsoredProductViewModel = ProductCellViewModel(
        id: product.id, 
        title: product.title,
        sellerName: product.sellerName,
        imageModel: createImageModel(imageUrlString: product.image),
        priceModel: createPriceModel(price: product.price, discountPrice: product.instantDiscountPrice),
        ratingModel: createRatingModel(averageRating: product.rate)
      )
     productViewModels.append(sponsoredProductViewModel)
    })
      
    return productViewModels
  }

  private func createImageModel(imageUrlString: String?) -> ProductImageViewModel {
    ProductImageViewModel(imageUrlString: imageUrlString, placeholderImage: .productPlaceholder)
  }
      
  private func createPriceModel(price: Float, discountPrice: Float?) -> PriceViewModel {
    PriceViewModel(
      price: (discountPrice != nil) ? priceFormatter.format(price) : nil,
      salePrice: priceFormatter.format(discountPrice ?? price)
    )
  }
      
  private func createRatingModel(averageRating: Float?) -> RatingViewModel? {
    guard let rating = averageRating else { return nil }
    return RatingViewModel(rating: rating)
  }
}
