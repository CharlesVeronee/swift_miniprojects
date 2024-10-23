import Foundation
import SwiftUI


struct BookDetail: View {
    @Environment (\.modelContext) private var modelContext
    @State var synopsisLoader = SynopsisLoader()
    @Bindable var book: Book
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                Spacer()
                AsyncImage(url: book.coverUrl) { image in image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200, maxHeight: 200)
                    
                } placeholder: {
                    if book.coverUrl != nil {
                        ProgressView()
                    } else {
                        Image(systemName: "book")
                    }
                }
                .frame(maxWidth: .infinity)
                
                Text(book.title)
                    .font(.title)
                
                Text(book.author)
                Toggle("Reading List", isOn: Bindable(book).readingList)
                  .fixedSize()

                
                switch synopsisLoader.state {
                case .idle: Color.clear
                case .loading: ProgressView()
                case .failed(let error): ScrollView { Text("Error Loading Synopsis") }
                case .success(let book):
                    SynopsisDisplay(book: book)
                }
            }
            .task { await synopsisLoader.loadBook(id: book.id)
                
            }
        }
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
              Button(book.readingList ? "Remove From List" : "Add To List") {
                book.readingList.toggle()
            }
          }
        }
        
    }
}

struct SynopsisDisplay: View {
    let book: OpenLibraryResponse
    
    var body: some View  {
        Text(book.responseContainer.synopsis)
            .padding()
    }
}


#Preview {
    let preview = PreviewContainer([Book.self])
    let book = Book.previewData[1]
    return NavigationStack {
        BookDetail(book: book)
            .modelContainer (preview.container)
    }
}


