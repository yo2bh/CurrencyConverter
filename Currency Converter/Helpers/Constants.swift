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

  // MARK: - Defaults
  static let emptyString = ""
  static let singleSpaceString = " "
  static let openingParenthesis = "("
  static let closingParenthesis = ")"
  
  // MARK: - Errors
  static let errorTitle = "Error"
  static let invalidURLString = "Invalid URL String."
  static let invalidAmount = "Invalid amount, please enter the valid amount."
  static let somethingWentWrong = "Something went wrong !!!\nPlease try after sometime."
  
  // MARK: - VC Id's
  static let unListedVC = "UnlistedCurrencyConverterVC"
  static let listedVC = "ListedCurrencyConverterVC"
  
  // MARK: - Cell identifiers
  static let currencyListCellIdentifier = "currencyListCell"
  static let listedCellIndentifier = "listedCurrencyCell"
  
  // MARK: - Other Strings
  static let networkInit = "Init Network Manager"
  static let applicationJson = "Application/json"
  static let contentType = "Content-Type"
  static let othersString = "Other Currency"
  static let otherDetailString = "Enter other currency for conversion"
  static let okButtonTitle = "Ok"
}
