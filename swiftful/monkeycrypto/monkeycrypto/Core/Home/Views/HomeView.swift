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
        ZStack {
            // content
            VStack {
                HStack {
                    CircleButtonView(image: !showPortfolio ? "info" : "chevron.left", isExpanded: .constant(false))
                    Spacer()
                    
                    if !showPortfolio {
                        Text("live prices")
                            .transition(.move(edge: .leading).combined(with: .opacity))
                            .font(.headline)
                            .foregroundStyle(Color.theme.accent)
                    } else {
                        Text("portfolio")
                            .transition(.move(edge: .trailing).combined(with: .opacity))
                            .font(.headline)
                            .foregroundStyle(Color.theme.accent)
                    }
                    
                    Spacer()
                    CircleButtonView(image: !showPortfolio ? "briefcase.fill" : "plus", isExpanded: $showPortfolio, label: "add coin")
                }
                .animation(.spring, value: showPortfolio)
                .padding(.horizontal)
                Spacer()
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}
