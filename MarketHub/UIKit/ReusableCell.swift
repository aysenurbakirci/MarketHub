//
//  ReusableCell.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 10.01.2024.
//

import UIKit

typealias ReusableTableViewCell = UITableViewCell & ReusableCell
typealias ReusableCollectionViewCell = UICollectionViewCell & ReusableCell

protocol ReusableCellViewModel {
  var cell: ReusableCell.Type { get }
}

protocol ReusableCell {
  func update(with viewModel: Any?)
}

extension ReusableCell {
  static var reuseIdentifier: String {
    return String(describing: Self.self)
  }
}
