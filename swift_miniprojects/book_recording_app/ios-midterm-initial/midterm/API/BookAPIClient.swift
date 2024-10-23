import CoreLocation
protocol BookAPI {
    func fetchBook(id: String) async throws -> OpenLibraryResponse
}

struct BookAPIClient: BookAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchBook(id: String) async throws -> OpenLibraryResponse {
        let path = BookEndpoint.path(id: id)
        let response: OpenLibraryResponse = try await performRequest(url: path)
        return response
    }
    
}
