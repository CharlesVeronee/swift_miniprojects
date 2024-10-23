import SwiftUI
import SwiftData

struct BookList: View {
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \Book.title) private var books: [Book]
    @State private var isPresentingBookForm: Bool = false
    @State private var newBookFormData = Book.FormData()
    
    var body: some View {
            NavigationStack {
                VStack {
                    List(books) {book in
                        NavigationLink(destination: BookDetail(book:book)) {
                            BookRow(book:book)
                        }
                    }
                }
                .navigationTitle("Books - ctv5")
                .onAppear {
                    if books.isEmpty {
                        for book in Book.previewData {
                            modelContext.insert(book)
                        }
                    }
                }
                
            }
            .toolbar {
              ToolbarItem(placement: .navigationBarTrailing) {
                Button("Create") {
                  isPresentingBookForm.toggle()
                }
              }
            }
            .sheet(isPresented: $isPresentingBookForm) {
              NavigationStack {
                BookForm(data: $newBookFormData)
                  .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                      Button("Cancel") { isPresentingBookForm.toggle()
                        newBookFormData = Book.FormData()
                      }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                      Button("Save") {
                        Book.create(from: newBookFormData, context: modelContext)
                        newBookFormData = Book.FormData()
                        isPresentingBookForm.toggle()                }
                    }
                  }
                  .navigationTitle("Add Book")
              }
            }
    }
}

#Preview {
    let preview = PreviewContainer([Book.self])
    preview.add(items: Book.previewData)
    return NavigationStack {
        BookList()
            .modelContainer (preview.container)
    }
}
