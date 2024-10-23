import Foundation
import SwiftUI
import SwiftData

struct RecipeIngredientsInstructions: View {
    let recipe: Recipe
    var scaleFactor: Double
    var body: some View {
        VStack (alignment: .leading){
            VStack (alignment: .leading){
                ForEach(recipe.unsectionedIngredients) {ingredient in
                    Text(ingredient.ingredientDisplay(ingredient, scaleFactor: scaleFactor))
                }
            }
            VStack(alignment: .leading){
                ForEach(recipe.sectionLabels, id: \.self) {label in
                    VStack (alignment: .leading){
                        Text(label).bold()
                        ForEach(recipe.ingredientsForSectionLabel(label)) { ingredient in
                            Text(ingredient.ingredientDisplay(ingredient, scaleFactor: scaleFactor))
                        }
                        Spacer()
                        
                    }
                }
            }
            Spacer()
            
            
            if !recipe.instructionsOrdered.isEmpty {
                VStack (alignment: .leading) {
                    Text("Instructions")
                        .bold()
                    ForEach(recipe.instructionsOrdered) { instruction in
                        Text(instruction.instructionText)
                    }
                }
            }
                            
                        
        }
        
    }
}




