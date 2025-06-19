//
//  HomeView.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/17/25.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            // content
            
            List {
                Color.clear
                    .frame(height: 50)
                ForEach(0 ..< 100) { _ in
                    CoinRowView(coin: .mock)
                }
            }
            .listStyle(.inset)
            .scrollEdgeEffectStyle(.soft, for: .all)

            header
                .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
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
                    .transition(.move(edge: .leading).combined(with: .opacity))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.theme.accent)
            } else {
                Text("portfolio")
                    .transition(.move(edge: .trailing).combined(with: .opacity))
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
