//
//  DoTryCatchThrows.swift
//  monkeyescape
//
//  Created by Matthew Fang on 6/5/25.
//

import SwiftUI

// TODO: protocols = flexible + segregated
// TODO: class inheritance = structured + bulky??

struct ColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

struct Protocols: View {
    let colorTheme: ColorThemeProtocol

    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            Text("Protocols!")
                .font(.headline)
                .foregroundStyle(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .cornerRadius(10)
        }
    }
}

#Preview {
    Protocols(colorTheme: ColorTheme())
}
