//
//  ErrorModel.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 13.01.2024.
//

import UIKit

struct ErrorModel {
  let title: String
  let description: String?
  let action: ErrorAction?
}

struct ErrorAction {
  let title: String
  let handler: ((UIAlertAction) -> Void)?
}
