//
//  CoinRowView.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/18/25.
//

import SwiftUI

struct CoinRowView: View {
    let coin: Coin
    let showHoldingsColumn: Bool = false

    var body: some View {
        HStack {
            leftColumn
            Spacer()

            if showHoldingsColumn {
                holdingsColumn
            }

            // MARK: use UIScreen.main.bounds for quick and dirty, screen-rotation-locked layouts when you don't want to wrap everything in a GeometryReader

            rightColumn
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.subheadline)
        .fontWeight(.semibold)
        .foregroundStyle(Color.theme.accent)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(coin: .dev)
}

extension CoinRowView {
    private var leftColumn: some View {
        HStack {
            Text(String(coin.rank))
                .font(.caption)
                .foregroundStyle(.secondaryText)
            Circle()
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
        }
    }

    private var holdingsColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.holdingsValue, format: .currency(code: "USD"))
            Text(coin.currentHoldings?.truncate(places: 2) ?? "0")
                .font(.caption)
                .fontWeight(.regular)
        }
    }

    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice, format: .currency(code: "USD"))
            if let changePercentage = coin.priceChangePercentage24H {
                Text(changePercentage.asPercent())
                    .font(.caption)
                    .fontWeight(.regular)
                    .foregroundStyle(changePercentage >= 0.0 ? Color.theme.green : Color.theme.red)
            }
        }
    }
}
