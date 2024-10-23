import SwiftUI
import SwiftData

struct ReadingList: View {
    @Query(filter: #Predicate<Book> { book in book.readingList },
           sort: \Book.title) private var books: [Book]

  var body: some View {
      List(books) { book in
          BookRow(book:book)
              .swipeActions(edge: .trailing) {
                 Button(role: .destructive) {
                  removeBook(book)
                } label: {
                  Label("", systemImage: "trash")
                }
              }
    }
      .navigationTitle("Reading List")
  }
    
    
    func removeBook(_ book: Book) {
        book.readingList = false
    }
}

#Preview {
  let preview = PreviewContainer([Book.self])
  preview.add(items: Book.previewData)
  return NavigationStack {
    ReadingList()
     .modelContainer (preview.container)
  }
}
