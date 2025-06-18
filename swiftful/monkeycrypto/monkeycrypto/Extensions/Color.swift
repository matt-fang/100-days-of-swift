//
//  Color.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/18/25.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

// MARK: having a theme struct lets us separate theme colors from default colors
struct ColorTheme {
    let accent = Color("AccentColor")
    let background = Color("BackgroundColor")
    let green = Color("GreenColor")
    let red = Color("RedColor")
    let secondaryText = Color("SecondaryTextColor")
}
