//
//  DoCatchTryThrows.swift
//  monkeyescape
//
//  Created by Matthew Fang on 6/8/25.
//

import Observation
import SwiftUI

class DoCatchTryThrowsManager {
    let isActive: Bool = true
    
    func getData() -> (title: String?, error: Error?) {
        if isActive {
            return ("NEW TITLE!", nil)
        } else {
            return (nil, URLError(.badURL))
        }
    }
    
    func getData2() -> Result<String, Error> {
        if isActive {
            return .success("NEW TEXT")
        } else {
            return .failure(URLError(.badURL))
        }
    }
    
    func getData3() throws -> String {
//        if isActive {
//            return "NEW TITLE!"
//        } else {
        throw URLError(.badServerResponse)
    }
    
    func getData4() throws -> String {
        if isActive {
            return "ANOTHER NEW TITLE!"
        } else {
            throw URLError(.badServerResponse)
        }
    }
}

@Observable class DoCatchTryThrowsViewModel {
    var text: String = "starting text"
    let manager = DoCatchTryThrowsManager()
    
//    func fetchData() {
//        let returnedValue = manager.getData()
//        if let newTitle = returnedValue.title {
//            self.text = newTitle
//        } else if let error = returnedValue.error {
//            self.text = error.localizedDescription
//        }
//    }
    
//    func fetchData2() {
//        let result = manager.getData2()
//
//        switch result {
//        case .success(let newTitle):
//            text = newTitle
//        case .failure(let error):
//            text = error.localizedDescription
//        }
//    }
    
    func fetchData4() {
        let newTitle = try? manager.getData3()
        if let newTitle = newTitle {
            text = newTitle
        }
        
        do {
            let finalTitle = try manager.getData4()
            text = finalTitle
        } catch {
            text = error.localizedDescription
        }
    }
}
    
struct DoCatchTryThrows: View {
    @State private var viewModel = DoCatchTryThrowsViewModel()
    
    var body: some View {
        Text(viewModel.text)
            .frame(width: 300, height: 300)
            .background(Color.blue)
            .cornerRadius(10)
            .onTapGesture {
                viewModel.fetchData4()
            }
    }
}

#Preview {
    DoCatchTryThrows()
}
