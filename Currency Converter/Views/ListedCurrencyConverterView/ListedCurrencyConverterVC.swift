//
//  ListedCurrencyConverterVC.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 30/08/21.
//

import UIKit

class ListedCurrencyConverterVC: UIViewController {
  // MARK: - IBOutlets
  
  // MARK: - Variables
  var selectedCurrency: String = AppConstants.emptyString
  var selectedCountryName: String = AppConstants.emptyString
  
  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = selectedCurrency + AppConstants.singleSpaceString + AppConstants.openingParenthesis + selectedCountryName + AppConstants.closingParenthesis
  }
}
