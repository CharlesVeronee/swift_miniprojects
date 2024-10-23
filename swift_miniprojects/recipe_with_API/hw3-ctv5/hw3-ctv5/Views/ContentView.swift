import SwiftUI

struct RecipeList: View {
    var body: some View {
        NavigationStack {
            List(Recipe.previewData) {recipe in
                NavigationLink(destination: RecipeDetail(recipe:recipe)) {
                    RecipeRow(recipe:recipe)
                }
            }
            .navigationTitle("Recipes - ctv5")
            .listStyle(.plain)
        }
    }
}

#Preview {
    RecipeList()
}
