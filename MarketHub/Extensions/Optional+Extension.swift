//
//  Optional+Extension.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 10.01.2024.
//

import Foundation

extension Optional where Wrapped: Collection {
  var isNilOrEmpty: Bool {
    guard let value = self else { return true }
    return value.isEmpty
  }
}
