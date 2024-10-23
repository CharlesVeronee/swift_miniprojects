import Foundation
import SwiftUI

@Observable
class SynopsisLoader {
    let apiClient = BookAPIClient()
    private(set) var state: LoadingState = .idle
    
    enum LoadingState {
        case idle
        case loading
        case success(data: OpenLibraryResponse)
        case failed(error: Error)
    }
    
    @MainActor
    func loadBook(id: String) async {
        self.state = .loading
        do {
            let result = try await apiClient.fetchBook(id: id)
            self.state = .success(data: result)
        } catch {
            self.state = .failed(error: error)
        }
    }
    
}
