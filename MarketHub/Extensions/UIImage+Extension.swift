//
//  UIImageView+Extension.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 10.01.2024.
//

import UIKit

extension UIImage {
  convenience init?(image: AssetIdentifier) {
    self.init(named: image.rawValue)
  }
}
