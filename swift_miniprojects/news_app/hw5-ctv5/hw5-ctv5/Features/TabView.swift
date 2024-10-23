import Foundation
import SwiftUI

struct TabContainer: View {
    var body: some View {
        TabView() {
            Headlines(HeadlinesLoader: HeadlinesLoader(apiClient: NewsAPIClient()))
                .tabItem {
                    Label("Headlines", systemImage: "newspaper")
                }
            Search(SearchLoader: SearchLoader(apiClient: NewsAPIClient()))
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}
