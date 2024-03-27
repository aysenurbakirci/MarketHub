//
//  UIView+Extensions.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 13.01.2024.
//

import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    views.forEach { view in
      addSubview(view)
    }
  }
}
