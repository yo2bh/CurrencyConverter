//
//  NonlistedCurrencyConverterVC.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 30/08/21.
//

import UIKit

class UnlistedCurrencyConverterVC: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var sourceCurrencyTextField: UITextField!
  @IBOutlet weak var destinationCurrencyTextField: UITextField!
  @IBOutlet weak var conversionLabel: UILabel!
  
  // MARK: - Constants
  let unlistedCurrencyViewModel = UnlistedCurrencyConverterViewModel()
  
  // MARK: - Variables
  private var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = AppConstants.othersString
    activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .large, color: UIColor.gray, placeInTheCenterOf: view)
    conversionLabel.text = AppConstants.emptyString
  }
  
  @IBAction func exchangeRateButtonPressed() {
    if let amount = getAmount(),
       let fromCurrency = getSourceCurrency(),
       let toCurrency = getDestinationCurrency() {
      self.activityIndicator.startAnimating()
      unlistedCurrencyViewModel.convertCurrency(amount, fromCurrency, toCurrency, success: handlerSuccess(_:_:), failure: handleFailure(_:))
    } else {
      AlertView.show(title: AppConstants.errorTitle, message: AppConstants.somethingWentWrong)
    }
  }
  
  func handlerSuccess(_ status: Bool, _ rate: Double?) {
    if status {
      DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()
        self.amountTextField.resignFirstResponder()
        if let rate = rate,
           let fromCurrency = self.getSourceCurrency(),
           let toCurrency = self.getDestinationCurrency(),
           let amount = self.getAmount() {
          // 1 USD = 73.072562 INR
          let conversion = fromCurrency + AppConstants.singleSpaceString + String(describing: amount) + AppConstants.singleSpaceString + AppConstants.equalToString + AppConstants.singleSpaceString + String(describing: rate * amount) + AppConstants.singleSpaceString + toCurrency
          self.conversionLabel.text = conversion
        }
      }
    }
  }
  
  func handleFailure(_ errorMessage: String) {
    DispatchQueue.main.async {
      self.conversionLabel.text = AppConstants.emptyString
      self.activityIndicator.stopAnimating()
      AlertView.show(title: AppConstants.errorTitle, message: errorMessage)
    }
  }
  
  func getAmount() -> Double? {
    if let amountString = amountTextField.text,
       let amount = Double(amountString) {
      return amount
    }
    return nil
  }
  
  func getSourceCurrency() -> String? {
    if let sourceCurrency = sourceCurrencyTextField.text {
      return sourceCurrency
    }
    return nil
  }
  
  func getDestinationCurrency() -> String? {
    if let destinationCurrency = destinationCurrencyTextField.text {
      return destinationCurrency
    }
    return nil
  }
  
}
