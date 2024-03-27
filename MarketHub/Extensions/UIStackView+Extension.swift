//
//  UIStackView+Extension.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 10.01.2024.
//

import UIKit

extension UIStackView {
  func addArrangedSubviews(_ views: UIView...) {
    views.forEach { view in
      addArrangedSubview(view)
    }
  }
    
  func removeAllArrangedSubviews() {
    arrangedSubviews.forEach { subview in
      self.removeArrangedSubview(subview)
      subview.removeFromSuperview()
    }
  }
}
