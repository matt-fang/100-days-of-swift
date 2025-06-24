//
//  CoinListView.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/22/25.
//

import SwiftUI

struct CoinListView: View {
    var coins: [Coin]
    var direction: Edge
    var showPortfolio: Bool
    
    var body: some View {
        List {
            Color.clear
                .frame(height: 30)
            listHeader
            ForEach(coins) { coin in
                CoinRowView(coin: coin)
            }
        }
        .listStyle(.inset)
        .scrollEdgeEffectStyle(.soft, for: .all)
        .transition(.move(edge: direction).combined(with: .opacity))
    }
    
    private var listHeader: some View {
        VStack {
            Spacer()
            HStack {
                Text("coin")
                Spacer()
                if showPortfolio {
                    Text("holdings")
                }
                Text("price")
                    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            }
            .font(.caption)
            .foregroundStyle(Color.theme.secondaryText)
        }
    }
}

//#Preview {
//    CoinListView(coins: HomeViewModel().allCoins, direction: .trailing, showPortfolio: .constant(true))
//}
