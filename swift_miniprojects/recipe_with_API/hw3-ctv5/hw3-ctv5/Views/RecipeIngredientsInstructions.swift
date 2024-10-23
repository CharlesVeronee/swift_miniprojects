import Foundation
import SwiftUI
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
            Text("Instructions")
                .bold()
            Spacer()
            ForEach(recipe.instructionsOrdered) {instruction in
                Text(instruction.instructionText)
                Spacer()
            }
            Spacer()
            Text("Notes")
                .bold()
                            
                        
        }
        
    }
}
