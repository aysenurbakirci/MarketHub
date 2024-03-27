//
//  PriceFormatter.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 13.01.2024.
//

import Foundation

protocol PriceFormatting {
  func format(_ price: Float) -> String
}

final class PriceFormatter: PriceFormatting {
  init() {}

  func format(_ price: Float) -> String {
    return "\(price)" + " TL"
  }
}
