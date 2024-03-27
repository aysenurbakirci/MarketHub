//
//  RatingViewModel.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 10.01.2024.
//

import Foundation

enum StarType {
  case empty, filled, half
}

struct RatingViewModel {
  let rating: Float
  var starTypes: [StarType] {
    createStarTypes()
  }

  private func createStarTypes() -> [StarType] {
    var starTypes: [StarType] = []
    let decimal = 5.0 - rating
    let empty = 5.0 - ceil(rating)
          
    for _ in 1...Int(rating) {
      starTypes.append(.filled)
    }
          
    if decimal > 0 {
      starTypes.append(.half)
    }
            
    if empty > 0 {
      for _ in 1...Int(empty) {
        starTypes.append(.empty)
       }
    }
    return starTypes
  }
}
