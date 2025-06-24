//
//  HomeView.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/17/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(HomeViewModel.self) private var viewModel
    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            // content
            VStack {
                if !showPortfolio {
                    CoinListView(coins: viewModel.allCoins, direction: .leading, showPortfolio: false)
                } else {
                    CoinListView(coins: viewModel.portfolioCoins, direction: .trailing, showPortfolio: true)
                }
            }

            header
                .padding(.horizontal)
        }
        .animation(.spring, value: showPortfolio)
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }.environment(HomeViewModel())
}

extension HomeView {
    private var header: some View {
        HStack {
            CircleButtonView(image: !showPortfolio ? "info" : "chevron.left", isExpanded: .constant(false))
                .onTapGesture {
                    showPortfolio.toggle()
                }
            Spacer()

            if !showPortfolio {
                Text("live prices")
                    .transition(.move(edge: .leading).combined(with: .blurReplace))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.accent)
            } else {
                Text("portfolio")
                    .transition(.move(edge: .trailing).combined(with: .blurReplace))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.accent)
            }

            Spacer()
            CircleButtonView(image: !showPortfolio ? "briefcase.fill" : "plus", isExpanded: $showPortfolio, label: "add coin")
                .onTapGesture {
                    showPortfolio.toggle()
                }
        }
        .animation(.spring, value: showPortfolio)
    }
}
