import SwiftUI
import SwiftData
import SwiftUI

struct RecipeList: View {
    @Environment (\.modelContext) private var modelContext
    @Query(sort: \Recipe.name) private var recipes: [Recipe]
    @State private var isPresentingForm: Bool = false
    @State private var newFormData = Recipe.FormData()
    

    
    var body: some View {
        NavigationStack {
            List(recipes) {recipe in
                NavigationLink(destination: RecipeDetail(recipe:recipe)) {
                    RecipeRow(recipe:recipe)
                }
            }
            .navigationTitle("Recipes - ctv5")
            .listStyle(.plain)
            
            
            .toolbar {
              ToolbarItem(placement: .navigationBarTrailing) {
                  Button("Add") {
                      isPresentingForm.toggle()}}}
            
            .sheet(isPresented: $isPresentingForm) {
                NavigationStack {
                  RecipeForm(recipe: $newFormData)
                    .toolbar {
                      ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") { isPresentingForm.toggle()
                          newFormData = Recipe.FormData()
                        }
                      }
                      ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                          Recipe.create(from: newFormData, context: modelContext)
                          newFormData = Recipe.FormData()
                          isPresentingForm.toggle()                }
                      }
                    }
                    .navigationTitle("Add Recipe")
                }}

        }
        .onAppear {
            if recipes.isEmpty {
                for recipe in Recipe.previewData {
                    modelContext.insert(recipe)
                }
            }
        }
    }
}

#Preview {

 let preview = PreviewContainer([Recipe.self])
    preview.add(items: Recipe.previewData)
    return NavigationStack {
        RecipeList()
            .modelContainer (preview.container)
    }

}
