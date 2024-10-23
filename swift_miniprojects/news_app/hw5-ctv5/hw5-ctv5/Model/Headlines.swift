import Foundation
import CoreLocation

struct NewsResponse: Decodable {
    var status: String
    var totalResults: Int
    var articles: [Article]
    
    static func mock() -> NewsResponse {
        NewsResponse(status: "ok", totalResults: 1, articles: [Article(source: Source(id: "123"), title: "Duke", description: "I LOVE DUKE", url: "abc.edu", publishedAt: "publisher")])
    }
}

struct Article: Decodable, Identifiable {
    var id: String {
        return url
    }
    var source: Source
    var author: String?
    var title: String?
    var description: String?
    var url: String
    var urlToImage: String?
    var publishedAt: String
    var content: String?
}

struct Source: Decodable, Identifiable {
    var id: String?
    var name: String?
}
