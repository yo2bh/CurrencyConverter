//
//  Constants.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 8/30/21.
//

import Foundation

struct AppConstants {
  static let currencyListURL = "http://api.currencylayer.com/list?access_key=c485b7876cc17accc56b819c679d1246"
  static let sourceSwitchingURL = "http://api.currencylayer.com/live?access_key=c485b7876cc17accc56b819c679d1246&source="
  static let networkInit = "Init Network Manager"
  static let invalidURLString = "Invalid URL String."
  static let applicationJson = "Application/json"
  static let contentType = "Content-Type"
  static let okButtonTitle = "Ok"
  static let errorTitle = "Error"
  static let currencyListCellIdentifier = "currencyListCell"
  static let othersString = "Other Currency"
  static let otherDetailString = "Enter other currency for conversion"
  static let emptyString = ""
  static let singleSpaceString = " "
  static let unListedVC = "UnlistedCurrencyConverterVC"
  static let listedVC = "ListedCurrencyConverterVC"
  static let openingParenthesis = "("
  static let closingParenthesis = ")"
}
