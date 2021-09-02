//
//  MockUnlistedCurrencyConverterVM.swift
//  Currency ConverterTests
//
//  Created by Yogesh Bharate on 02/09/21.
//

import XCTest
@testable import Currency_Converter

class MockUnlistedCurrencyVM: UnlistedCurrencyConverterViewModel {
  
  var isSuccess: Bool!
  
  override func convertCurrency(_ amount: Double,
                       _ fromCurrency: String,
                       _ toCurrency: String,
                       success: @escaping(_ status: Bool, _ exchangeRate: Double?) -> Void,
                       failure: @escaping(_ error: String) -> Void) {
    if isSuccess {
      success(true, 73.072542)
    } else {
      failure(AppConstants.somethingWentWrong)
    }
  }
}

