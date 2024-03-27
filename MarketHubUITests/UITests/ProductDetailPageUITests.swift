//
//  MarketHubUITestsLaunchTests.swift
//  MarketHubUITests
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import XCTest

final class ProductDetailPageUITests: XCTestCase {
  func test_assertDetailPageContent() {
    launch()

    //Step: Open listing page
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.listingPage))
      .assert(grey_minimumVisiblePercent(0.5))

    //Step: Open detail page
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.sponsoredProductCell(id: "220")))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.listingPage))
      .assert(grey_minimumVisiblePercent(0.5))
      .perform(grey_tap())
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.detailPage))
      .assert(grey_minimumVisiblePercent(0.5))
    
    //Step: Assert image cell
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.imageSliderCell))
      .assert(grey_minimumVisiblePercent(0.5))
    
    //Step: Assert detail cell and detail texts
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.productInformationCell))
      .assert(grey_minimumVisiblePercent(0.5))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.productDetailTitle))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.productInformationCell))
      .assert(grey_text("Apple iPhone 12 Pro 256 GB (Apple Türkiye Garantili)"))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.productDetailDescription))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.productInformationCell))
      .assert(grey_text("APPLE TÜRKİYE GARANTİLİ-SIFIR ÜRÜN - 🚚AYNI GÜN KARGO-AKSESUARSIZ KUTU- APPLE TÜRKİYE GARANTİLİ"))
      
    //Step: Assert rating cell and star views
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.productRatingCell))
      .assert(grey_minimumVisiblePercent(0.5))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.ratingStarView(index: "0", type: "filled")))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.productRatingCell))
      .assert(grey_minimumVisiblePercent(0.5))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.ratingStarView(index: "1", type: "filled")))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.productRatingCell))
      .assert(grey_minimumVisiblePercent(0.5))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.ratingStarView(index: "2", type: "filled")))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.productRatingCell))
      .assert(grey_minimumVisiblePercent(0.5))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.ratingStarView(index: "3", type: "filled")))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.productRatingCell))
      .assert(grey_minimumVisiblePercent(0.5))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.ratingStarView(index: "4", type: "half")))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.productRatingCell))
      .assert(grey_minimumVisiblePercent(0.5))
      
    //Step: Assert price view and price details
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.productPriceCell))
      .assert(grey_minimumVisiblePercent(0.5))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.priceText))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.productPriceCell))
      .assert(grey_text("24229.0 TL"))
    EarlGrey
      .selectElement(with: grey_accessibilityID(AccessibilityIdentifiers.discountPriceText))
      .inRoot(grey_accessibilityID(AccessibilityIdentifiers.productPriceCell))
      .assert(grey_text("22229.0 TL"))
  }
}

extension ProductDetailPageUITests {
  private func launch() {
    let application: XCUIApplication = XCUIApplication()
    application.launch()
  }
}
