//
//  ListedCurrencyConverterVC.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 30/08/21.
//

import UIKit

class ListedCurrencyConverterVC: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var amountTextField: UITextField!
  @IBOutlet weak var exchangeRateTableView: UITableView!
  
  // MARK: - Variables
  var selectedCurrency: String = AppConstants.emptyString
  var selectedCountryName: String = AppConstants.emptyString
  private var activityIndicator: UIActivityIndicatorView!
  private var enteredAmount: Double = 1.0
  
  // MARK: - Constants
  let quotesViewModel = ListedCurrencyViewModel()
  
  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = selectedCurrency + AppConstants.singleSpaceString + AppConstants.openingParenthesis + selectedCountryName + AppConstants.closingParenthesis
    activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .large, color: UIColor.gray, placeInTheCenterOf: view)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    exchangeRateTableView.isHidden = true
  }
  
  @IBAction func exchangeRateButtonPressed() {
    if let amount = getAmount() {
      enteredAmount = amount
      activityIndicator.startAnimating()
      // Use "USD" in place of selectedCurrency to get the response from server
      quotesViewModel.fetchQuotes(amount, selectedCurrency, success: handlerSuccess(_:), failure: handleFailure(_:))
    } else {
      AlertView.show(title: AppConstants.errorTitle, message: AppConstants.invalidAmount)
    }
  }
  
  func handlerSuccess(_ status: Bool) {
    if status {
      DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()
        self.exchangeRateTableView.isHidden = false
        self.amountTextField.resignFirstResponder()
        self.exchangeRateTableView.reloadData()
      }
    }
  }
  
  func handleFailure(_ errorMessage: String) {
    DispatchQueue.main.async {
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
}

// MARK: - TableView Delegate Methods
extension ListedCurrencyConverterVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return quotesViewModel.getQuotes().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.listedCellIndentifier)
    let row = indexPath.row
    let quotes = quotesViewModel.getQuotes()
    cell?.textLabel?.text = Array(quotes)[row].key
    // Multiple by enter amount to get the exchange rate for amount.
    cell?.detailTextLabel?.text = String(describing: Array(quotes)[row].value * enteredAmount)
    
    return cell!
  }
}
