//
//  ActivityIndicator.swift
//  Currency Converter
//
//  Created by Yogesh Bharate on 8/30/21.
//

import UIKit

extension UIActivityIndicatorView {
  convenience init(activityIndicatorStyle: UIActivityIndicatorView.Style, color: UIColor, placeInTheCenterOf parentView: UIView) {
    self.init(style: activityIndicatorStyle)
    center = parentView.center
    self.color = color
    parentView.addSubview(self)
  }
}
