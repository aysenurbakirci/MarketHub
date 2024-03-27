//
//  ImageOperations.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 11.01.2024.
//

import UIKit

final class ImageLoader {
  static let shared = ImageLoader()

  private let cache: NSCache<NSString, UIImage> = {
    let cacheLimitInMegabytes: Int = 50
    let cache = NSCache<NSString, UIImage>()
    cache.totalCostLimit = cacheLimitInMegabytes * 1024 * 1024
    return cache
  }()

  private init() {}

  func loadImage(
    from urlString: String?,
    placeholder: UIImage,
    completion: @escaping (UIImage) -> Void
  ) {
    completion(placeholder)
    guard let urlString = urlString, let url = URL(string: urlString) else {
      return
    }
    if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
      completion(cachedImage)
      return
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data, let downloadedImage = UIImage(data: data) else {
        completion(placeholder)
        return
      }
      self.cache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
      completion(downloadedImage)
    }.resume()
  }
}
