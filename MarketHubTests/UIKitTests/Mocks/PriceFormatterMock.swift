//
//  PriceFormatterMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

final class PriceFormatterMock: PriceFormatting {
  var formatPriceCalled = false
  var formatPriceValue: Float?
  var formatPriceReturnValue: String?

  func format(_ price: Float) -> String {
    formatPriceCalled = true
    formatPriceValue = price
    return formatPriceReturnValue ?? "Formatted Price"
  }
}
