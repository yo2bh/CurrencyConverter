//
//  AlertView.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 8/30/21.
//

import UIKit

class AlertView {
  
  static func show(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let OkButton = UIAlertAction(title: AppConstants.okButtonTitle, style: .cancel, handler: nil)
    
    alert.addAction(OkButton)
    
    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.present(alert, animated: true, completion: nil)
  }
}
