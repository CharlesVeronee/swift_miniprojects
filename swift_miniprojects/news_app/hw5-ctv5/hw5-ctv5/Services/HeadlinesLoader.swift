import Foundation
import SwiftUI

@Observable
class HeadlinesLoader {
    let apiClient: NewsAPI
    private(set) var state: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case success(data: NewsResponse)
        case failed(error: Error)
    }
    
    init(apiClient: NewsAPI) {
        self.apiClient = apiClient
    }
    
    @MainActor
    func loadHeadlines() async {
        self.state = .loading
        do {
            let headlines = try await apiClient.fetchHeadlines()
            self.state = .success(data: headlines)
        } catch {
            self.state = .failed(error: error)
        }
    }
    
}
