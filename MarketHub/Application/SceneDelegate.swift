//
//  SceneDelegate.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  var window: UIWindow?

  func scene(
    _ scene: UIScene,
    willConnectTo session: UISceneSession,
    options connectionOptions: UIScene.ConnectionOptions
  ) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
      
    let window = UIWindow(windowScene: windowScene)
    window.rootViewController = ProductListPageBuilder.build()
    self.window = window
    window.makeKeyAndVisible()
  }
}

