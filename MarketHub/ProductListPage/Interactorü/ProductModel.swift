//
//  ProductModel.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import Foundation

struct ProductListModel: Decodable {
  let page: String
  let nextPage: String?
  var sponsoredProducts: [ProductModel]?
  var products: [ProductModel]
}

struct ProductModel: Decodable {
  let id: Int
  let title: String
  let image: String?
  let price: Float
  let instantDiscountPrice: Float?
  let rate: Float?
  let sellerName: String?
}

extension ProductModel: Equatable {}
extension ProductListModel: Equatable {}
