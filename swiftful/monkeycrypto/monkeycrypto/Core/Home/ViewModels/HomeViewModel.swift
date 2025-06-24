//
//  HomeViewModel.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/22/25.
//

import Foundation
import Observation

@Observable class HomeViewModel {
    private let service: CoinDataService = CoinDataService()
    var allCoins: [Coin] = []
    var portfolioCoins: [Coin] = []
    
    init() {
        observeService()
    }
    
    private func observeService() {
        Task {
            do {
                let stream = try await service.getCoins()
                for await coin in stream {
                    self.allCoins.append(coin)
                }
            } catch {
                print("error:", error)
            }
        }
    }
}
