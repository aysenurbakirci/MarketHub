//
//  ModelsMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductListMockModels {
  static let productCellViewModel = ProductCellViewModel(
    id: 110,
    title: "Phone",
    sellerName: "Seller",
    imageModel: productImageViewModel,
    priceModel: priceViewModel,
    ratingModel: ratingModel
  )
    
  static let sponsoredProductCellViewModel = SponsoredProductCellViewModel(
    id: 220,
    title: "Phone",
    bannerTitle: "Sponsored",
    imageModel: productImageViewModel,
    priceModel: priceViewModel,
    ratingModel: ratingModel
  )
    
  static let ratingModel = RatingViewModel(rating: 3.4)
    
  static let priceViewModel = PriceViewModel(price: "4500", salePrice: "4000")
    
  static let productImageViewModel = ProductImageViewModel(
    imageUrlString: "",
    placeholderImage: .productPlaceholder
  )

  static let errorModel = ErrorModel(
    title: "Error",
    description: "Unknown",
    action: nil
  )

  static let productListModel = ProductListModel(
    page: "1",
    nextPage: "2",
    sponsoredProducts: [sponsoredProductModel],
    products: [productModel, productModel2]
  )
    
  static let productModel = ProductModel(
    id: 1,
    title: "Product 1",
    image: "image1.jpg",
    price: 4500,
    instantDiscountPrice: 4500,
    rate: 2.1,
    sellerName: "Seller"
  )
    
  static let productModel2 = ProductModel(
    id: 2,
    title: "Product 2",
    image: "image2.jpg",
    price: 2000,
    instantDiscountPrice: 1870,
    rate: 4.7,
    sellerName: "Seller"
  )
    
  static let sponsoredProductModel = ProductModel(
    id: 3,
    title: "Sponsored Product 1",
    image: "image3.jpg",
    price: 4500,
    instantDiscountPrice: 4000,
    rate: 3.4,
    sellerName: "Seller"
  )

  static let opening = ProductDetailOpening(productId: 1)
}
