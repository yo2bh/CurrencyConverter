//
//  CurrencyListViewModel.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 30/08/21.
//

import Foundation

class CurrencyListViewModel {
  // MARK: - Variables
  private var currencyList = [String: String]()
  
  // MARK: - Methods
  func fetchCurrencyList(success: @escaping(_ status: Bool) -> Void,
                         failure: @escaping(_ errorMessage: String) -> Void) {
    NetworkManager.shared.sendRequest(AppConstants.currencyListURL, completionHandler: { data, error in
      if let data = data {
        do {
          let response = try JSONDecoder().decode(CurrencyListModel.self, from: data)
          self.setCurrencyList(response.currencies)
          success(true)
        } catch {
          debugPrint(error.localizedDescription)
          failure(error.localizedDescription)
        }
      } else if let errorMessage = error {
        failure(errorMessage)
      }
    })
  }
  
  private func setCurrencyList(_ currencies: [String: String]) {
    self.currencyList = currencies
  }
  
  func getCurrencyList() -> [String: String] {
    return currencyList
  }
}
