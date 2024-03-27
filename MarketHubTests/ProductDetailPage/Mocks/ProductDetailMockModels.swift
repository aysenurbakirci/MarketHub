//
//  ProductDetailMockModels.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class ProductDetailMockModels {
  static let productDetailModel = ProductDetailModel(
    title: "Test Product",
    description: "This is a test product.",
    images: ["image1", "image2"],
    price: 100.0,
    instantDiscountPrice: 80.0,
    rate: 4.5,
    sellerName: "Seller"
  )
}

