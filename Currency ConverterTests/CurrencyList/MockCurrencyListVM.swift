//
//  MockCurrencyListVM.swift
//  Currency ConverterTests
//
//  Created by Yogesh Bharate on 02/09/21.
//

import XCTest
@testable import Currency_Converter

class MockCurrencyListVM: CurrencyListViewModel {
  var isSuccess: Bool!
  override func fetchCurrencyList(success: @escaping(_ status: Bool) -> Void,
                                  failure: @escaping(_ errorMessage: String) -> Void) {
    if isSuccess {
      success(true)
    } else {
      failure(AppConstants.somethingWentWrong)
    }
  }
}
