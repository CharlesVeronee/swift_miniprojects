import Foundation
import SwiftUI
import SwiftData

struct RecipeDetail: View {
    @Bindable var recipe: Recipe
    @State var scaleFactor: Double = 1.0
    @State private var isPresentingForm: Bool = false
    @State private var editFormData: Recipe.FormData = Recipe.FormData()
    
    
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
                                Image(systemName: "fork.knife")
                            }
                        }
                    }
                    .frame(maxWidth: 100, maxHeight: 100)
                    
                    Text(recipe.name)
                        .bold()
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
                    
                    HStack{
                        Text("Scale The Recipe")
                            .bold()
                        PickerView(scaleFactor: $scaleFactor)
                    }
                    
                    RecipeIngredientsInstructions(recipe:recipe, scaleFactor: scaleFactor)
                        .padding(50)
                    
                    VStack (alignment: .leading){
                        Text("Notes")
                            .bold()
                    }
                    TextEditor(text: $recipe.notes)
                        .frame(height:200)
                    
                    
                    
                    
                }
                .padding(10)
                
            }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    editFormData = recipe.dataForForm
                    isPresentingForm.toggle()
            }
          }
        }
        .sheet(isPresented: $isPresentingForm) {
            NavigationStack {
                RecipeForm(recipe: $editFormData)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Cancel") { isPresentingForm.toggle() }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Save") {
                                Recipe.update(recipe, from: editFormData)
                                isPresentingForm.toggle()
                  }
                }
              }
          }
        }
        
    }
}
