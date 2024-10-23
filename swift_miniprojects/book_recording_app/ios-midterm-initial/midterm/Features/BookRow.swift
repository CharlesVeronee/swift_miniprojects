import Foundation
import SwiftUI

struct BookRow: View {
    let book: Book
    var body: some View {
        HStack{
            AsyncImage(url: book.coverUrl) { image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
            } placeholder: {
                if book.coverUrl != nil {
                    ProgressView()
                } else {
                    Image(systemName: "book")
                }
            }
            .frame(maxWidth: 100, maxHeight: 100)
            VStack{
                Text(book.title)
                    .bold()
                Text(book.author)
            }
        }
    }
}
