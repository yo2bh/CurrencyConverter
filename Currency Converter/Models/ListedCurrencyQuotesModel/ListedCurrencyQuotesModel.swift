//
//  ListedCurrencyQuotesModel.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 01/09/21.
//

import Foundation

struct ListedCurrencyQuotesModel: Decodable {
  var success: Bool
  var source: String
  var quotes: [String: Double]
}
