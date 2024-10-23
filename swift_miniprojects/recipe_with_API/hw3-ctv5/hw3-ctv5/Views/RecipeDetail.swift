import Foundation
import SwiftUI

struct RecipeDetail: View {
    @Bindable var recipe: Recipe
    @State var scaleFactor: Double = 1.0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10){
                HStack{
                    AsyncImage(url: recipe.thumbnailUrl) { image in image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        if recipe.thumbnailUrl != nil {
                            ProgressView()
                        } else {
                            Image(systemName: "film.fill")
                        }
                    }
                }
                .frame(maxWidth: 100, maxHeight: 100)
                Text(recipe.name)
                Button {
                    if recipe.lastPreparedAt != nil {
                        recipe.lastPreparedAt = nil
                    }
                    else {
                        recipe.lastPreparedAt = Date.now
                    }
                    
                } label: {
                    HStack {
                        Text("Previously Prepared")
                        if recipe.lastPreparedAt != nil {
                            Image(systemName: "checkmark.circle.fill")
                        } else {
                            Image(systemName: "circle")
                        }
                    }
                }
                Text(recipe.cuisine.cuisineString)
                HStack{
                    Text("Scale The Recipe")
                        .bold()
                    PickerView(scaleFactor: $scaleFactor)
                }
                RecipeIngredientsInstructions(recipe:recipe, scaleFactor: scaleFactor)
                    .padding(50)
                
                
                TextEditor(text: $recipe.notes)
                    .frame(height:200)
                    .border(Color.gray, width: 1)
                
                

            }
            .padding(10)
        }
        
    }
}
