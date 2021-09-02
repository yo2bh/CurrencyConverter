//
//  ListedCurrencyConverterTests.swift
//  Currency ConverterTests
//
//  Created by Yogesh Bharate on 02/09/21.
//

import XCTest
@testable import Currency_Converter

class ListedCurrencyConverterTests: XCTestCase {
  
  var vc: ListedCurrencyConverterVC!
  
  override func setUpWithError() throws {
    vc = makeSUT()
  }
  
  func makeSUT() -> ListedCurrencyConverterVC {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let sut = storyboard.instantiateViewController(identifier: AppConstants.listedVC) as! ListedCurrencyConverterVC
    sut.selectedCurrency = "INR"
    sut.selectedCountryName = "India"
    sut.loadViewIfNeeded()
    return sut
  }
  
  func testListedCurrencyConverterView() {
    vc.viewDidLoad()
    XCTAssertNotNil(vc.quotesViewModel)
    XCTAssert(vc.quotesViewModel.getQuotes().count == 0)
    XCTAssertEqual(vc.selectedCurrency,"INR")
    XCTAssertEqual(vc.selectedCountryName, "India")
  }
  
  func testListedCurrencyVM() {
    let mockListedCurrencyVM = MockListedCurrencyVM()
    // Test Success case
    mockListedCurrencyVM.isSuccess = true
    mockListedCurrencyVM.fetchQuotes(102.25, "USD") { (response) in
      XCTAssertTrue(response)
    } failure: { _ in
    }
    
    // Test failure case
    mockListedCurrencyVM.isSuccess = false
    mockListedCurrencyVM.fetchQuotes(0, "USD") { _ in
    } failure: { (error) in
      XCTAssertEqual(error, AppConstants.somethingWentWrong)
    }
  }
  
  func testListedCurrencyConverterModel() {
    let data = """
    {
      "success": true,
      "terms": "https://currencylayer.com/terms",
      "privacy": "https://currencylayer.com/privacy",
      "timestamp": 1630065198,
      "source": "USD",
      "quotes": {
        "USDAED": 3.67301,
        "USDAFN": 86.125012,
        "USDALL": 103.693562,
        "USDAMD": 492.319074,
      }
    }
    """.data(using: .utf8)!
    let response = try? JSONDecoder().decode(ListedCurrencyQuotesModel.self, from: data)
    XCTAssertEqual(response?.success, true)
    XCTAssertEqual(response?.quotes.count, 4)
    XCTAssertEqual(response?.quotes["USDAED"], 3.67301)
  }
}
