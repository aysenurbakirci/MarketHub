//
//  AccessibilityIdentifiers.swift
//  MarketHubUITests
//
//  Created by Ayşe Nur Bakırcı on 15.01.2024.
//

import Foundation

final class AccessibilityIdentifiers {
  //MARK: Listing Page
  static var listingPage: String { createAccessibilityIdentifier(#function) }
  static func sponsoredProductCell(id: String) -> String {
      createAccessibilityIdentifier(#function, id)
  }
  static func productCell(id: String) -> String {
      createAccessibilityIdentifier(#function, id)
  }
    
  //MARK: Detail Page
  static var detailPage: String { createAccessibilityIdentifier(#function) }
  static var imageSliderCell: String { createAccessibilityIdentifier(#function) }
  static var productInformationCell: String { createAccessibilityIdentifier(#function) }
  static var productDetailTitle: String { createAccessibilityIdentifier(#function) }
  static var productDetailDescription: String { createAccessibilityIdentifier(#function) }
  static var productPriceCell: String { createAccessibilityIdentifier(#function) }
  static var banner: String { createAccessibilityIdentifier(#function) }
  static var productRatingCell: String { createAccessibilityIdentifier(#function) }
    
  //MARK: RatingView
  static func ratingStarView(index: String, type: String) -> String {
    createAccessibilityIdentifier(#function, type, index)
  }
  static var averageRatingText: String { createAccessibilityIdentifier(#function) }
    
  //MARK: PriceView
  static var priceText: String { createAccessibilityIdentifier(#function) }
  static var discountPriceText: String { createAccessibilityIdentifier(#function) }
}

extension AccessibilityIdentifiers {
  private static func createAccessibilityIdentifier(_ props: String...) -> String {
    var accessibility: String = String(describing: self)
    props.forEach { string in
      accessibility += string
    }
    return accessibility
  }
}
