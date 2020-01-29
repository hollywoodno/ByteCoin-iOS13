//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct CoinManager {
  
  let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
  let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
  
  func getCoinPrice(for currencySymbol: String) {
    let currencyURLString = "\(baseURL)\(currencySymbol)"
    print("Request url string: \(currencyURLString)")
    performRequest(with: currencyURLString)
  }
  
  func performRequest(with urlString: String) {
    
    if let requestURL = URL(string: urlString) {
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: requestURL) { (data, response, error) in
        if error != nil {
          print("Issue retrieving bitcoin data")
        }
        
        if let data = data {
          let dataString = String(data: data, encoding: String.Encoding.utf8) as String?
          print("Retrieved bitcoin data: \(dataString)")
        }

      }
      
      task.resume()
    }
  }
}
