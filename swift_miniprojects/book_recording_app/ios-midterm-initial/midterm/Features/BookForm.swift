import Foundation
import SwiftUI

struct BookForm: View {
    @Binding var data: Book.FormData
    
    var body: some View {
        Form {
            TextFieldWithLabel(label: "ID", text: $data.id, prompt: "ID")
            TextFieldWithLabel(label: "Title", text: $data.title, prompt: "Title")
            TextFieldWithLabel(label: "Author", text: $data.author, prompt: "Author")
        }
    }
}
