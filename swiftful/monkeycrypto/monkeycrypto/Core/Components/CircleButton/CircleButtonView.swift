//
//  CircleButtonView.swift
//  monkeycrypto
//
//  Created by Matthew Fang on 6/18/25.
//

import SwiftUI

struct CircleButtonView: View {
    var image: String
    @Binding var isExpanded: Bool
    var label: String?

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: .infinity)
                .foregroundStyle(!isExpanded ? AnyShapeStyle(Color.gray.opacity(0.3)) : AnyShapeStyle(Color.theme.accent))
            HStack {
                Image(systemName: image)
                    .font(.headline)
                    .frame(width: 20, height: 20)

                    .foregroundStyle(!isExpanded ? Color.theme.accent : Color.black)
                    
                if
                    let label = label,
                    isExpanded == true {
                    Text(label)
                        .foregroundStyle(Color.black)
                        .font(.headline)
                }
            }
            .padding()
        }
        .frame(width: !isExpanded ? 50 : 150, height: 50)
        .animation(.spring(duration: 0.5, bounce: 0.4), value: isExpanded)
        .onTapGesture {
            isExpanded.toggle()
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonView(image: "info", isExpanded: .constant(true), label: "Info")
        .padding()
    CircleButtonView(image: "plus", isExpanded: .constant(true), label: "Add")
        .padding()
}
