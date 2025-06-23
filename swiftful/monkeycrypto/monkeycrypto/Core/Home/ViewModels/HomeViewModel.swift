//
//  HomeViewModel.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/22/25.
//

import Foundation
import Observation

@Observable class HomeViewModel {
    var allCoins: [Coin] = []
    var portfolioCoins: [Coin] = []
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.allCoins.append(Coin.dev)
            self.portfolioCoins.append(Coin.dev)
            self.portfolioCoins.append(Coin.dev)
        }
    }
}
