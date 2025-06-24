//  CoinDataServices.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/23/25.
//

import Foundation

class CoinDataService {
    var allCoins: [Coin] = []

//    init() {
//        Task {
//            try? await getCoins()
//        }
//    }

    func getCoins() async throws -> AsyncStream<Coin> {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else { throw URLError(.badURL) }

        let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
        
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200,
            response.statusCode < 300
        else {
            throw URLError(.badServerResponse)
        }
        
        let coins = try JSONDecoder().decode([Coin].self, from: data)
        
        // TODO: this avoids any strong self — no need to implement weak self!
        return AsyncStream { continuation in
            for coin in coins {
                continuation.yield(coin)
            }
            continuation.finish()
        }
        
    }
}
