//
//  DependencyInjection.swift
//  monkeyescape
//
//  Created by Matthew Fang on 6/5/25.
//

import Combine
import Observation
import SwiftUI

// TODO: LEARN CODABLE AND JSON STUFF
struct PostsModel: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

// TODO: LEARN COMBINE HOLY
class ProductionDataService {
    let url: URL = .init(string: "https://jsonplaceholder.typicode.com/posts")!
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

@Observable class DependencyInjectionViewModel {
    var dataArray: [PostsModel] = []

    init() {
        loadPosts()
    }

    private func loadPosts() {}
}

struct DependencyInjection: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    DependencyInjection()
}
