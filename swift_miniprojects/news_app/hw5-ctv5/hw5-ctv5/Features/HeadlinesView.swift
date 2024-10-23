import SwiftUI

struct Headlines: View {
    let HeadlinesLoader: HeadlinesLoader
    
    var body: some View {
        VStack {
            Spacer()
            Button("Get Headlines") {
                Task {
                    await HeadlinesLoader.loadHeadlines()
                }
                
            }
            .buttonStyle(.borderedProminent)
            
            
            Spacer()
            switch HeadlinesLoader.state {
            case .idle: Color.clear
            case .loading: ProgressView()
            case .failed(let error): ScrollView { Text("Error \(error.localizedDescription)") }
            case .success(let headlines):
                HeadlinesDisplay(headlines: headlines)
            }
        }
        .task { await HeadlinesLoader.loadHeadlines()
        }
    }
}

struct HeadlinesDisplay: View {
    let headlines: NewsResponse
    
    var body: some View {
        ScrollView {
            ForEach(headlines.articles) { article in
                VStack(alignment: .leading, spacing: 10) {
                    HStack{
                        if let urlString = article.urlToImage, let url = URL(string: urlString) {
                            
                            AsyncImage(url: url) { image in image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            } placeholder: {
                                if article.urlToImage != nil {
                                    ProgressView()
                                }
                            }
                        }
                        else {Image(systemName: "newspaper")
                        }
                    }
                    if let title = article.title {
                        Text(title)
                            .fontWeight(.bold)
                    }
                    if let description = article.description{
                        Text(description)
                            .italic()
                    }
                    
                    Divider()
                }
                .padding()
            }
        }
        
    }
}

#Preview {
    Headlines(HeadlinesLoader: HeadlinesLoader(apiClient: MockNewsAPIClient()))
}
