//
//  Currency_ConverterTests.swift
//  Currency ConverterTests
//
//  Created by Yogesh Bharate on 8/30/21.
//

import XCTest
@testable import Currency_Converter

class CurrencyListTests: XCTestCase {
  
  var vc: CurrencyListViewController!
  
  override func setUpWithError() throws {
    vc = makeSUT()
  }
  
  func makeSUT() -> CurrencyListViewController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let sut = storyboard.instantiateViewController(identifier: "CurrencyListViewController") as! CurrencyListViewController
    sut.loadViewIfNeeded()
    return sut
  }
  
  func testCurrencyListView() {
    vc.viewDidLoad()
    XCTAssertNotNil(vc.currencyListViewModel)
    XCTAssert(vc.currencyListViewModel.getCurrencyList().count == 0)
  }
  
  func testCurrencyListVM() {
    let mockCurrencyListVM = MockCurrencyListVM()
    // Test Success case
    mockCurrencyListVM.isSuccess = true
    mockCurrencyListVM.fetchCurrencyList { (response) in
      XCTAssertTrue(response)
    } failure: { _ in
    }
    
    // Test failure case
    mockCurrencyListVM.isSuccess = false
    mockCurrencyListVM.fetchCurrencyList { _ in
    } failure: { (error) in
      XCTAssertEqual(error, AppConstants.somethingWentWrong)
    }
  }
  
  func testCurrencyListModel() {
    let data = """
    {
      "success": true,
      "terms": "https://currencylayer.com/terms",
      "privacy": "https://currencylayer.com/privacy",
      "currencies": {
        "AED": "United Arab Emirates Dirham",
        "AFN": "Afghan Afghani",
        "ALL": "Albanian Lek"
      }
    }
    """.data(using: .utf8)
    let response = try? JSONDecoder().decode(CurrencyListModel.self, from: data!)
    XCTAssertEqual(response?.currencies.count, 3)
    XCTAssertEqual(response?.currencies["AED"], "United Arab Emirates Dirham")
  }
}
