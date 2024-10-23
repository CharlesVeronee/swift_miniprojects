import Foundation
import CoreLocation

struct BookEndpoint {
    static let baseURL = "https://openlibrary.org/works/"
    
    
    static func path(id: String) -> String {
        let id = id
        
        return "\(baseURL)\(id).json"
        
        //https://openlibrary.org/works/OL45804W.json
        
    }
}



