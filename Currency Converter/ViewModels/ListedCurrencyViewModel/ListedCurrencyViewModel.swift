//
//  ListedCurrencyViewModel.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 01/09/21.
//

import Foundation

class ListedCurrencyViewModel {
  // MARK: - Variables
  private var quotes = [String: Double]()
  
  // MARK: - Methods
  func fetchQuotes(source: String,
                   success: @escaping(_ status: Bool) -> Void,
                   failure: @escaping(_ errorMessage: String) -> Void) {
    let urlString = AppConstants.sourceSwitchingURL + source
    NetworkManager.shared.sendRequest(urlString, completionHandler: { data, error in
      if let data = data {
        do {
          let response = try JSONDecoder().decode(ListedCurrencyQuotesModel.self, from: data)
          self.setQuotes(source, response.quotes)
          success(response.success)
        } catch {
          debugPrint(error.localizedDescription)
          failure(error.localizedDescription)
        }
      } else if let errorMessage = error {
        failure(errorMessage)
      }
    })
  }
  
  private func setQuotes(_ sourceCurrency: String, _ quotes: [String: Double]) {
    // Remove the source currency name from response.
    var quoteList = Dictionary<String, Double>()
    // Don't show the quotes for currency equal to source currency.i.e ex USDUSD
    for (key, value) in quotes where key != sourceCurrency+sourceCurrency {
      let newKey = key.replacingOccurrences(of: sourceCurrency, with: AppConstants.emptyString)
      quoteList[newKey] = value
    }
    self.quotes = quoteList
  }
  
  func getQuotes() -> [String: Double] {
    return quotes
  }
}
