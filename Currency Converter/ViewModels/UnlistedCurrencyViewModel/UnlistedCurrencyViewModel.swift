//
//  UnlistedCurrencyViewModel.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 02/09/21.
//

import Foundation

class UnlistedCurrencyConverterViewModel {
  
  func convertCurrency(_ amount: Double,
                       _ fromCurrency: String,
                       _ toCurrency: String,
                       success: @escaping(_ status: Bool, _ exchangeRate: Double?) -> Void,
                       failure: @escaping(_ error: String) -> Void) {
    // Validate amount
    if !Validator.validateAmount(amount) {
      failure(AppConstants.invalidAmount)
    }
    // Validate from and to Currency
    if !Validator.validateCurrency(fromCurrency) || !Validator.validateCurrency(toCurrency) {
      failure(AppConstants.invalidCurrency)
    }
    
    let currency = fromCurrency + AppConstants.underscoreString + toCurrency
    let url = AppConstants.currencyConvertURL + currency + AppConstants.apiKey
    NetworkManager.shared.sendRequest(url) { data, error in
      if let data = data {
        do {
          let response = try JSONDecoder().decode([String: Double].self, from: data)
          // If response is empty it means user enter Invalid Currency, show error
          response.count > 0 ? success(true, Array(response).first?.value): failure(AppConstants.invalidCurrency)
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
