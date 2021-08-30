//
//  CurrencyListModel.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 30/08/21.
//

import Foundation

struct CurrencyListModel: Decodable {
  var currencies: [String: String]
}
