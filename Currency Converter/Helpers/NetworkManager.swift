//
//  NetworkManager.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 8/30/21.
//

import Foundation

enum RequestType: String {
  case post = "POST"
  case get = "GET"
  case put = "PUT"
}

final class NetworkManager {
  // MARK: - Properties
  static let shared = NetworkManager()
  // Initialization
  private init() {
    debugPrint(AppConstants.networkInit)
  }
  
  public func sendRequest(_ urlString: String, _ requestType: RequestType = .get, _ requestParameters: [String: Any]? = nil, completionHandler:@escaping(_ response: Data?, _ error: String?) -> Void) {
    // Create URL Request
    guard let url = URL(string: urlString) else {
      completionHandler(nil, AppConstants.invalidURLString)
      return
    }
    
    var requestURL = URLRequest(url: url)
    requestURL.httpMethod = requestType.rawValue
    requestURL.setValue(AppConstants.applicationJson, forHTTPHeaderField: AppConstants.contentType)
    
    if let requestParameters = requestParameters {
      guard let httpBody = try? JSONSerialization.data(withJSONObject: requestParameters,
                                                       options: []) else {
        return
      }
      requestURL.httpBody = httpBody
    }
    
    URLSession.shared.dataTask(with: requestURL, completionHandler: { data, response, error in
      completionHandler(data, error?.localizedDescription)
    }).resume()
  }
}

