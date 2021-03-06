//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
  func didGetLastCurrencyPrice(lastPrice: String, currency: String)
  func didFailWithError(error: Error)
}

struct CoinManager {
  
  let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
  let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
  var delegate: CoinManagerDelegate?
  
  func getCoinPrice(for currencySymbol: String) {
    let urlString = "\(baseURL)\(currencySymbol)"
    
    if let requestURL = URL(string: urlString) {
      let session = URLSession(configuration: .default)
      let task = session.dataTask(with: requestURL) { (data, response, error) in
        if error != nil {
          print("Issue retrieving bitcoin data: \(String(describing: error))")
          self.delegate?.didFailWithError(error: error!)
          return
        }
        
        if let data = data {
          let bitcoin = self.parseJSON(data)
          if let bitcoin = bitcoin {
            let bitcoinString = String(format: "%.2f", bitcoin.last)
            self.delegate?.didGetLastCurrencyPrice(lastPrice: bitcoinString, currency: currencySymbol)
          }
        }

      }
      
      task.resume()
    }
  }
  
  func parseJSON(_ data: Data) -> BitcoinModel? {
    let decoder = JSONDecoder()
    
    do {
      let bitcoin = try decoder.decode(BitcoinModel.self, from: data)
      return bitcoin
    } catch {
      print("Error parsing json: \(error)")
      delegate?.didFailWithError(error: error)
      return nil
    }
    
  }
}
