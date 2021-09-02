//
//  UnlistedCurrencyViewModel.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 02/09/21.
//

import Foundation

class CustomCurrencyConverterViewModel {
  
  func convertCurrency(_ fromCurrency: String,
                       _ toCurrency: String,
                       success: @escaping(_ exchangeRate: Double?) -> Void,
                       failure: @escaping(_ error: String) -> Void) {
    let currency = fromCurrency + AppConstants.underscoreString + toCurrency
    let url = AppConstants.currencyConvertURL + currency + AppConstants.apiKey
    NetworkManager.shared.sendRequest(url) { data, error in
      if let data = data {
        do {
          let response = try JSONDecoder().decode([String: Double].self, from: data)
          success(response[currency])
        } catch {
          debugPrint(error.localizedDescription)
          failure(error.localizedDescription)
        }
      } else if let errorMessage = error {
        failure(errorMessage)
      }
    }
  }
}
