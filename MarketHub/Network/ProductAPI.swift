//
//  ProductAPI.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 10.01.2024.
//

import Foundation

enum ProductAPI: Network {
  case listing(page: String)
  case productDetail(id: Int)
    
  var schema: String {
    "http"
   }

  var host: String {
    "private-d3ae2-n11case.apiary-mock.com"
  }

  var path: String {
    switch self {
    case let .listing(page):
      return "/listing" + "/\(page)"
    case .productDetail(_):
      return "/product"
    }
  }

  var method: HttpMethod {
    switch self {
    case .listing, .productDetail:
      return .get
    }
  }

  var queryItems: [String : String]? {
    switch self {
    case let .productDetail(id):
      return ["productId": "\(id)"]
    default:
      return nil
    }
  }
}
