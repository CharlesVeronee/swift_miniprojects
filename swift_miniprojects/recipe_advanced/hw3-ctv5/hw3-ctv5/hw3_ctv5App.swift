//
//  hw3_ctv5App.swift
//  hw3-ctv5
//
//  Created by Charles Teague Veronee on 2/7/24.
//

import SwiftUI
import SwiftData

@main
struct hw3_ctv5App: App {
  var body: some Scene {
      WindowGroup {
          RecipeList()
              .modelContainer(for: Recipe.self)
      }
  }
}



