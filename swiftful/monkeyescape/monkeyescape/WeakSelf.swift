//
//  WeakSelf.swift
//  monkeyescape
//
//  Created by Matthew Fang on 6/4/25.
//

import Observation
import SwiftUI

struct WeakSelf: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                WeakSelfSecondScreen()
            } label: {
                Text("navigate!")
            }
            .navigationTitle("Screen 1")
        }
    }
}

@Observable
final class WeakSelfSecondScreenViewModel {
    var data: String? = nil

    init() {
        print("VM initialized!")
        getData()
    }

    deinit {
        print("VM deinit-ed!")
    }

    func getData() {
        data = "new data!"
    }
}

struct WeakSelfSecondScreen: View {
    @State var viewModel = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        VStack {
            Text("Second View!")
                .navigationTitle("Screen 2")
            if let data = viewModel.data {
                Text(data)
            }
        }
    }
}

#Preview {
    WeakSelf()
}
