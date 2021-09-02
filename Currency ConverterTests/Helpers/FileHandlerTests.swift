//
//  FileHandlerTests.swift
//  Currency ConverterTests
//
//  Created by Yogesh Bharate on 02/09/21.
//

import XCTest
@testable import Currency_Converter

class FileHandlerTests: XCTestCase {
  
  func testWriteFile() {
    let data = populateFileData()
    // Write data in file
    FileHandler.shared.writeFile("ExchangeRate", data)
    // Read data from file
    let fileData = FileHandler.shared.readFile("ExchangeRate")
    XCTAssertNotNil(fileData)
  }
  
  func testReadFile() {
    // Test failure case
    let data = FileHandler.shared.readFile("Abc")
    XCTAssertNil(data)
    // Write data in file
    FileHandler.shared.writeFile("Quotes", populateFileData())
    // Test success case
    let fileData = FileHandler.shared.readFile("Quotes")
    XCTAssert(fileData != nil)
  }
  
  func populateFileData() -> Data {
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
    return data
  }
}
