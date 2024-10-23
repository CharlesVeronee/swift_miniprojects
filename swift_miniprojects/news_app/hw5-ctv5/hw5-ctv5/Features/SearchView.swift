import Foundation
import SwiftUI

struct Search: View {
    @State private var text = ""
    let SearchLoader: SearchLoader
    
    var body: some View {
        VStack {
            Spacer()
            TextFieldWithLabel(placeholder: "Search", text: $text)
            .cornerRadius(5)
            .border(Color.black, width: 1)
            .padding()
            .onSubmit {
                Task {
                    if !text.isEmpty {
                        await SearchLoader.loadSearch(searchTerm: text)
                    }
                }
            }
            
            
            
            Button("Get Articles") {
                if !text.isEmpty {
                    Task {
                        await SearchLoader.loadSearch(searchTerm: text)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            
            Spacer()
            switch SearchLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(let error): ScrollView { Text("Error \(error.localizedDescription)") }
            case .success(let headlines):
                HeadlinesDisplay(headlines: headlines)
            }
        }
    }
}

struct TextFieldWithLabel: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .disableAutocorrection(true)
            .padding(.bottom, 20)
    }
}

#Preview {
    Search(SearchLoader: SearchLoader(apiClient: MockNewsAPIClient()))
}
