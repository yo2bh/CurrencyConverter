//
//  ValidatorTests.swift
//  Currency ConverterTests
//
//  Created by Yogesh Bharate on 02/09/21.
//

import XCTest
@testable import Currency_Converter

class ValidatorTests: XCTestCase {
  
  func testValidateAmount() {
    XCTAssertFalse(Validator.validateAmount(0))
    XCTAssertTrue(Validator.validateAmount(105.3))
    XCTAssertFalse(Validator.validateCurrency("AEDWT"))
    XCTAssertTrue(Validator.validateCurrency("AED"))
  }
}
