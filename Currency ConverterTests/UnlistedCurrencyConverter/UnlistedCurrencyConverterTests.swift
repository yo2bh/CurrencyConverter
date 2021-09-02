//
//  UnlistedCurrencyConverterTests.swift
//  Currency ConverterTests
//
//  Created by Yogesh Bharate on 02/09/21.
//

import XCTest
@testable import Currency_Converter

class UnlistedCurrencyConverterTests: XCTestCase {
  
  var vc: UnlistedCurrencyConverterVC!
  
  override func setUpWithError() throws {
    vc = makeSUT()
  }

  func makeSUT() -> UnlistedCurrencyConverterVC {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let sut = storyboard.instantiateViewController(identifier: AppConstants.unListedVC) as! UnlistedCurrencyConverterVC
    sut.loadViewIfNeeded()
    return sut
  }
  
  func testListedCurrencyConverterView() {
    vc.viewDidLoad()
    XCTAssertNotNil(vc.unlistedCurrencyViewModel)
  }
  
  func testUnlistedCurrencyVM() {
    let mockUnlistedCurrencyVM = MockUnlistedCurrencyVM()
    // Test Success case
    mockUnlistedCurrencyVM.isSuccess = true
    mockUnlistedCurrencyVM.convertCurrency(25, "USD", "INR", success: { (status, rate) in
      XCTAssertTrue(status)
      XCTAssertNotNil(rate)
    }, failure: { _ in
    })
    
    // Test failure case
    mockUnlistedCurrencyVM.isSuccess = false
    mockUnlistedCurrencyVM.convertCurrency(0, "USD", "INR", success: { (status, rate) in
    }, failure: { error in
      XCTAssertEqual(error, AppConstants.somethingWentWrong)
    })
  }
}
