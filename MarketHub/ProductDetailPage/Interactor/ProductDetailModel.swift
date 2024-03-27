//
//  ProductDetailModel.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import Foundation

struct ProductDetailModel: Decodable {
  let title: String
  let description: String
  let images: [String]
  let price: Float
  let instantDiscountPrice: Float?
  let rate: Float?
  let sellerName: String?
}
