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
    if let data = FileHandler.shared.readFile(source),
       !isTimeExceed(source) {
      self.parseResponse(source, data) { (response) in
        success(response)
      } failure: { (error) in
        failure(error)
      }
    } else {
      self.sendQuotesRequest(source: source) { (response) in
        success(response)
      } failure: { (error) in
        failure(error)
      }
    }
  }
  
  func getQuotes() -> [String: Double] {
    return quotes
  }
  
  private func sendQuotesRequest(source: String,
                         success: @escaping(_ status: Bool) -> Void,
                         failure: @escaping(_ errorMessage: String) -> Void) {
    let urlString = AppConstants.sourceSwitchingURL + source
    NetworkManager.shared.sendRequest(urlString, completionHandler: { data, error in
      if let data = data {
        // Parse JSON Response
        self.parseResponse(source, data) { (response) in
          // Write data to the file
          FileHandler.shared.writeFile(source, data)
          success(response)
        } failure: { (error) in
          failure(error)
        }
      } else if let errorMessage = error {
        failure(errorMessage)
      }
    })
  }
  
  private func parseResponse(_ source: String,
                             _ data: Data,
                             success: @escaping(_ status: Bool) -> Void,
                             failure: @escaping(_ errorMessage: String) -> Void) {
    do {
      let response = try JSONDecoder().decode(ListedCurrencyQuotesModel.self, from: data)
      self.setQuotes(source, response.quotes)
      success(response.success)
    } catch {
      debugPrint(error.localizedDescription)
      failure(AppConstants.somethingWentWrong)
    }
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
  
  private func isTimeExceed(_ fileName: String) -> Bool {
    /**
     Check the difference between last modified file date and current date if greater than 30 minutes, send the network request otherwise load data from file.
     */
    if let lastModifyDate = FileHandler.shared.getFileModificationTime(fileName) {
      let diff = Int(Date().timeIntervalSince1970 - lastModifyDate.timeIntervalSince1970)
      let hours = diff / 3600
      let minutes = (diff - hours * 3600) / 60
      return minutes > 30
    }
    return true
  }
}
