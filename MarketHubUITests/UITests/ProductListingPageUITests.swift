//
//  MarketHubUITests.swift
//  MarketHubUITests
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import XCTest

final class ProductListingPageUITests: XCTestCase {
  func test_goDetailPageFromSponsoredProducts() {
    launch()
      
    //Step: Open listing page
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.listingPage))
      .assert(grey_minimumVisiblePercent(0.5))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.sponsoredProductCell(id: "220")))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.listingPage))
      .assert(grey_minimumVisiblePercent(0.5))
      .perform(grey_tap())
      
    //Step: Open detail page
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.detailPage))
      .assert(grey_minimumVisiblePercent(0.5))
  }
    
  func test_goDetailPageFromProducts() {
    launch()
      
    //Step: Open listing page
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.listingPage))
      .assert(grey_minimumVisiblePercent(0.5))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.productCell(id: "110")))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.listingPage))
      .assert(grey_minimumVisiblePercent(0.5))
      .perform(grey_tap())
      
    //Step: Open detail page
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.detailPage))
      .assert(grey_minimumVisiblePercent(0.5))
  }

  func test_scrollingInListingPage() {
    launch()

    //Step: Open and test listing page
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.listingPage))
      .assert(grey_minimumVisiblePercent(0.5))
      .perform(grey_scrollToContentEdge(.bottom))
  }
}

extension ProductListingPageUITests {
  private func launch() {
    let application: XCUIApplication = XCUIApplication()
    application.launch()
  }
}
