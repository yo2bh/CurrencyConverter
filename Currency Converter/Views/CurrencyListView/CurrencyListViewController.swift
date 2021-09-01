//
//  ViewController.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 8/30/21.
//

import UIKit

class CurrencyListViewController: UIViewController {
  // MARK: - IBOutlets
  @IBOutlet weak var currencyListTable: UITableView!
  
  // MARK: - Variables
  var currencyListViewModel = CurrencyListViewModel()
  private var activityIndicator: UIActivityIndicatorView!
  
  // MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .large, color: UIColor.gray, placeInTheCenterOf: view)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    currencyListTable.isHidden = true
    activityIndicator.startAnimating()
    currencyListViewModel.fetchCurrencyList(success: handlerSuccess(_:), failure: handleFailure(_:))
  }
  
  func handlerSuccess(_ status: Bool) {
    if status {
      DispatchQueue.main.async {
        self.activityIndicator.stopAnimating()
        self.currencyListTable.isHidden = false
        self.currencyListTable.reloadData()
      }
    }
  }
  
  func handleFailure(_ errorMessage: String) {
    DispatchQueue.main.async {
      self.activityIndicator.stopAnimating()
      AlertView.show(title: AppConstants.errorTitle, message: errorMessage)
    }
  }
}

// MARK: - Table View Delegate Methods
extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currencyListViewModel.getCurrencyList().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: AppConstants.currencyListCellIdentifier)
    let row = indexPath.row
    let currencyList = currencyListViewModel.getCurrencyList()
    cell?.textLabel?.text = Array(currencyList)[row].value
    cell?.detailTextLabel?.text = Array(currencyList)[row].key
    // Append Other Currency option at end
    if currencyListViewModel.getCurrencyList().count - 1 == row {
      cell?.textLabel?.text = AppConstants.othersString
      cell?.detailTextLabel?.text = AppConstants.otherDetailString
    }
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let row = indexPath.row
    let currencyList = currencyListViewModel.getCurrencyList()
    
    if currencyList.count - 1 == row,
       let vc = self.storyboard?.instantiateViewController(identifier: AppConstants.unListedVC) as? UnlistedCurrencyConverterVC {
      self.navigationController?.pushViewController(vc, animated: true)
    } else if let vc = self.storyboard?.instantiateViewController(identifier: AppConstants.listedVC) as? ListedCurrencyConverterVC {
      let selectedRow = Array(currencyList)[row]
      let selectedCountryName = selectedRow.value
      let selectedCurrency = selectedRow.key
      vc.selectedCurrency = selectedCurrency
      vc.selectedCountryName = selectedCountryName
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}
