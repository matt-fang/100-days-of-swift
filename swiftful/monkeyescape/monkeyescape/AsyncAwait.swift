//
//  AsyncAwait.swift
//  monkeyescape
//
//  Created by Matthew Fang on 6/13/25.
//

import Observation
import SwiftUI

@Observable class AsyncAwaitViewModel {
    var dataArray: [String] = []

    func addTitle1() {
        // MARK: DispatchQueue does not use async! it uses escaping closures! so no need for async, but be mindful of self vs. weak self

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.dataArray.append("title1: \(Thread.current)")
        }
    }
    
    // MARK: ALWAYS SWITCH BACK ONTO THE MAINACTOR BEFORE UPDATING YOUR UI (this includes views AND viewmodels)
    func addTitle2() {
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let title = "Title2 : \(Thread.current)"
            DispatchQueue.main.async {
                self.dataArray.append(title)

                let title3 = "Title3 : \(Thread.current)"
                self.dataArray.append(title3)
            }
        }
    }
    
    func addAuthor1() async {
        let author1 = "Author1: \(Thread.current)"
        self.dataArray.append(author1)
        
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        await MainActor.run {
            let author2 = "Author2: \(Thread.current)"
            self.dataArray.append(author2)
            
        }
    }
}

struct AsyncAwait: View {
    @State private var viewModel = AsyncAwaitViewModel()
    var body: some View {
        List {
            ForEach(viewModel.dataArray, id: \.self) { data in
                Text(data)
            }
        }.onAppear {
            Task {
                await viewModel.addAuthor1( )
            }
//            viewModel.addTitle1()
//            viewModel.addTitle2()
        }
    }
}

#Preview {
    AsyncAwait()
}
