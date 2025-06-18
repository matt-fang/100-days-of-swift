//
//  DownloadImageAsync.swift
//  monkeyescape
//
//  Created by Matthew Fang on 6/13/25.
//

import Combine
import Observation
import SwiftUI

class DownloadImageAsyncImageLoader {
    let url = URL(string: "https://picsum.photos/200")!

    // MARK: our entire escaping closure gets executed AFTER the function runs (it's asynchronous - that's the whole point), so swift needs to ESCAPE the closure (keep it alive) from the function that's trying to close/forget it immediately (which would work for non-escaping closures, but not here)

    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200,
            response.statusCode < 300
        else {
            return nil
        }
        return image
    }

    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        
        // MARK: with escaping closures, you literally need to GO INTO the function + access all of the API responses from the INSIDE to update the viewModel
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, error)
        }
        .resume()
    }

    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse) // gives us the UIImage?
            .mapError { $0 } // gives us the error
            .eraseToAnyPublisher()
    }
    
    // MARK: with async, on the other hand, you're just RETURNING the API response! so much cleaner!
    
    func downloadWithAsync() async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            let image = handleResponse(data: data, response: response)
            return image
        } catch {
            throw error
        }
    }
}

@Observable class DownloadImageAsyncViewModel {
    var image: UIImage?
    let loader = DownloadImageAsyncImageLoader()
    var cancellables = Set<AnyCancellable>()

    // MARK: remember - your get functions will almost always modify properties of the VIEWMODEL! (self.var = ...)

    // MARK: you can also throw in self whenever you want - more doesn't hurt

    func fetchImage() async {
        /*
//        loader.downloadWithEscaping { [weak self] image, _ in
//            DispatchQueue.main.async {
//                self?.image = image
//            }
//        }
//        loader.downloadWithCombine()
//            .receive(on: DispatchQueue.main)
//            .sink { _ in
//
//            } receiveValue: { [weak self] image in
//                self?.image = image
//            }
//            .store(in: &cancellables)
        loader.download
         */
        
        // MARK: you can get the return value + update the viewModel ... all outside of any claustrophobic closure!
        
        let image = try? await loader.downloadWithAsync()
        self.image = image
    }
}

struct DownloadImageAsync: View {
    @State private var viewModel = DownloadImageAsyncViewModel()

    var body: some View {
        VStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
            }
            Button("Reload Image") {
                // MARK: async functions can only be called + awaited inside OTHER async functions
                // MARK: but where do we start then ... ?
                // MARK: it makes sense to make the viewModel fetchData() function async
                // MARK: but when you get to the views, just use a Task to start the concurrency environment for you
                Task {
                    await viewModel.fetchImage()
                }
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .padding()
        }
        .onAppear {
            Task {
                await viewModel.fetchImage()
            }
        }
    }
}

#Preview {
    DownloadImageAsync()
}
