import Foundation
import CoreLocation

struct NewsEndpoint {
    static let baseURL = "https://newsapi.org/v2"
    static let apiKey = "4c1f5ed1d8bc4200a1b61bb3c8f56069"
    
    
    static func path() -> String {
        let query = "top-headlines"
        let country = "us"
        
        return "\(baseURL)/\(query)?country=\(country)&apiKey=\(apiKey)"
        
        //https://newsapi.org/v2/top-headlines?country=us&apiKey=4c1f5ed1d8bc4200a1b61bb3c8f56069
        
    }
}

struct SearchEndpoint {
    static let baseURL = "https://newsapi.org/v2"
    static let apiKey = "4c1f5ed1d8bc4200a1b61bb3c8f56069"
    
    
    static func path(searchTerm: String) -> String {
        let searchTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let query = "everything"
        
        
        
        return "\(baseURL)/\(query)?q=\(searchTerm)&apiKey=\(apiKey)"
        
        //https://newsapi.org/v2/everything?q=bitcoin&apiKey=4c1f5ed1d8bc4200a1b61bb3c8f56069
        
    }
}

