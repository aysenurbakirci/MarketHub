//
//  ProductNetworkOperations.swift
//  MarketHub
//
//  Created by Ayşe Nur Bakırcı on 9.01.2024.
//

import Foundation

enum HttpMethod : String {
  case get = "GET"
}

protocol Network {
  var schema: String { get }
  var host: String { get }
  var path: String { get }
  var method : HttpMethod {get}
  var queryItems: [String: String]? { get }
  func request () -> URLRequest?
}

extension Network {
  func request() -> URLRequest? {
    var urlComponents = URLComponents()
    var queryItems: [URLQueryItem] = []
                
    urlComponents.scheme = schema
    urlComponents.host = host
    urlComponents.path += path
            
    self.queryItems?.forEach { (name, value) in
      queryItems.append(URLQueryItem(name: name, value: value))
    }
    urlComponents.queryItems = queryItems
          
    guard let url = urlComponents.url else {
      return nil
    }
    var request = URLRequest(url: url)
    request.httpMethod = method.rawValue
                
    return request
  }
}

final class NetworkManager {
  static let shared = NetworkManager()

  private init() { }

  func executeRequest <T:Decodable> (
    _ network : Network,
    completion : @escaping (Result<T , Error>) ->Void)
  {
    guard let request = network.request() else { return completion(.failure(NSError(domain: "", code: -1)))}
    let urlSessionTask = URLSession.shared.dataTask(with: request) { (data ,response , error) in
      if let error = error {
        completion(.failure(error))
      }
      if let data = data {
        do {
          let jsonData = try JSONDecoder().decode(T.self, from: data)
          completion(.success(jsonData))
        } catch let error {
          completion(.failure(error))
        }
      }
    }
    urlSessionTask.resume()
  }
}
