//
//  NetworkMock.swift
//  MarketHubTests
//
//  Created by Ayşe Nur Bakırcı on 14.01.2024.
//

import XCTest
@testable import MarketHub

struct NetworkMock: Network {
    var schema: String { return "https" }
    var host: String { return "example.com" }
    var path: String { return "/api/test" }
    var method: HttpMethod { return .get }
    var queryItems: [String: String]? { return ["param1": "value1", "param2": "value2"] }
}
