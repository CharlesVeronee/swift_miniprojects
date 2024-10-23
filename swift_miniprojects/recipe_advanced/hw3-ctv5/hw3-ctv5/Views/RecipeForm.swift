import SwiftUI

struct RecipeForm: View {
  @Binding var recipe: Recipe.FormData

  var body: some View {
    Form {
        TextFieldWithLabel(label: "Title", text: $recipe.name, prompt: "Enter a Name")
        TextFieldWithLabel(label: "Details", text: $recipe.details, prompt: "Enter Details")
        TextFieldWithLabel(label: "Credit", text: $recipe.credit, prompt: "Enter Credit")
        
        Picker(selection: $recipe.mealCourse, label: Text("Meal Course")) {
        ForEach(Recipe.MealCourse.allCases) { mealCourse in
          Text(mealCourse.rawValue)
        }
      }
      .pickerStyle(.menu)
      VStack(alignment: .leading) {
        Text("Thumbnail URL")
          .bold()
          .font(.caption)
        TextField("Thumbnail URL", text: $recipe.thumbnailUrl, prompt: Text("Enter a URL"))
      }
        
        Toggle("Previously Prepared", isOn: $recipe.previouslyPrepared)
        if recipe.previouslyPrepared {
            DatePicker("Last Prepared", selection: $recipe.lastPreparedAt)
        }
        
      VStack(alignment: .leading) {
        Text("Notes")
          .bold()
          .font(.caption)
          TextEditor(text: $recipe.notes)
          .frame(height: 200)
      }
    }
  }
}
