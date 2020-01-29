//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  // MARK: - Properties
  
  @IBOutlet weak var bitcoinLabel: UILabel!
  @IBOutlet weak var currencyLabel: UILabel!
  @IBOutlet weak var currencyPicker: UIPickerView!
  
  var coinManager = CoinManager()
  
  // MARK: - Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    currencyPicker.dataSource = self
    currencyPicker.delegate = self
    coinManager.delegate = self
  }
  
}

// MARK: - Extensions

// MARK: - PickerView Data Source and Delegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return coinManager.currencyArray.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return coinManager.currencyArray[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let selectedCurrency = coinManager.currencyArray[row]
    self.currencyLabel.text = selectedCurrency
    coinManager.getCoinPrice(for: selectedCurrency)
  }
}

// MARK: - CoinManager Delegate

extension ViewController: CoinManagerDelegate {
  func didGetLastCurrencyPrice(lastPrice: String, currency: String) {
    
    DispatchQueue.main.async {
      self.bitcoinLabel.text = lastPrice
      self.currencyLabel.text = currency
    }
  }
  
  func didFailWithError(error: Error) {
    print("Failed to retrieve bitcoin price data: \(error)")
  }
}



