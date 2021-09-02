//
//  Validator.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 02/09/21.
//

import Foundation

struct Validator {
  static func validateAmount(_ amount: Double) -> Bool {
    return amount > 0
  }
  
  static func validateCurrency(_ currency: String) -> Bool {
    return currency.count == 3
  }
}
