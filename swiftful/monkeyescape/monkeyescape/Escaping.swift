//
//  ContentView.swift
//  monkeyescape
//
//  Created by Matthew Fang on 6/4/25.
//

import SwiftUI
import Observation

@Observable
final class EscapingViewModel {
    var text: String = "Hello"
    
    func getData() {
        downloadData3 { [weak self] returnedData in
            self?.text = returnedData
        }
    }
    
    func downloadData() -> String {
        return "New data!"
    }
    
    func downloadData2(completion: (_ data: String) -> ()) {
        completion("new data!")
    }

    func downloadData3(completion: @escaping (_ data: String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion("new data!")
        }
    }
}

struct Escaping: View {
    @State var viewModel = EscapingViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding()
            .onTapGesture {
                viewModel.getData()
            }
    }
}

#Preview {
    Escaping()
}
