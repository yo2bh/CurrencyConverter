//
//  Constants.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 8/30/21.
//

import Foundation

struct AppConstants {
  // MARK: - API URLs
  static let currencyListURL = "http://api.currencylayer.com/list?access_key=c485b7876cc17accc56b819c679d1246"
  static let sourceSwitchingURL = "http://api.currencylayer.com/live?access_key=c485b7876cc17accc56b819c679d1246&source="
  static let currencyConvertURL = "https://free.currconv.com/api/v7/convert?q="
  static let apiKey = "&compact=ultra&apiKey=3d829c238a670ef4b802"

  // MARK: - Defaults
  static let emptyString = ""
  static let singleSpaceString = " "
  static let openingParenthesis = "("
  static let closingParenthesis = ")"
  static let underscoreString = "_"
  static let equalToString = "="
  
  // MARK: - Errors
  static let errorTitle = "Error"
  static let invalidURLString = "Invalid URL String."
  static let invalidAmount = "Invalid amount, please enter the valid amount."
  static let somethingWentWrong = "Something went wrong !!!\nPlease try after sometime."
  static let invalidCurrency = "Invalid currency, please enter the valid currency."
  
  // MARK: - VC Id's
  static let unListedVC = "UnlistedCurrencyConverterVC"
  static let listedVC = "ListedCurrencyConverterVC"
  
  // MARK: - Cell identifiers
  static let currencyListCellIdentifier = "currencyListCell"
  static let listedCellIndentifier = "listedCurrencyCell"
  
  // MARK: - Other Strings
  static let networkInit = "Init Network Manager"
  static let fileManagerInit = "Init File Manager"
  static let applicationJson = "Application/json"
  static let contentType = "Content-Type"
  static let othersString = "Other Currency"
  static let otherDetailString = "Enter other currency for conversion"
  static let okButtonTitle = "Ok"
  static let txtExtension = ".txt"
}
