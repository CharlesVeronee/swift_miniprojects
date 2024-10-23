import CoreLocation
protocol NewsAPI {
    func fetchHeadlines() async throws -> NewsResponse
    func fetchSearch(searchTerm: String) async throws -> NewsResponse
    
}

struct NewsAPIClient: NewsAPI, APIClient {
    let session: URLSession = .shared
    
    func fetchHeadlines() async throws -> NewsResponse {
        let path = NewsEndpoint.path()
        let response: NewsResponse = try await performRequest(url: path)
        return response
    }
    
    func fetchSearch(searchTerm: String) async throws -> NewsResponse {
        let path = SearchEndpoint.path(searchTerm: searchTerm)
        let response: NewsResponse = try await performRequest(url: path)
        return response
    }
    
}

struct MockNewsAPIClient: NewsAPI {
    
    func fetchHeadlines() async throws -> NewsResponse {
        NewsResponse.mock()
    }
    
    func fetchSearch(searchTerm: String) async throws -> NewsResponse {
        NewsResponse.mock()
    }
}
