//
//  Achievement.swift
//  hw1-ctv5
//
//  Created by Charles Teague Veronee on 1/22/24.
//
import Foundation
import SwiftUI

@Observable
class Achievement: Identifiable {
  let id: Int
  let prompt: String
  var achieved: Bool

  init(id: Int, prompt: String, achieved: Bool = false) {
    self.id = id
    self.prompt = prompt
    self.achieved = achieved
  }

  static func createCard(number: Int) -> [Achievement] {
    guard number <= possibleAchievments.count else { return [] }
    var cardAchievements: [Achievement] = []
    while cardAchievements.count < number {
        let randomIndex = Int(arc4random_uniform(UInt32(possibleAchievments.count)))
        let possibleAchievement = possibleAchievments[randomIndex]
      if !cardAchievements.contains(where: { $0.id == possibleAchievement.id }) {
        possibleAchievement.achieved = false
        cardAchievements.insert(possibleAchievement, at: 0)
      }
    }
    return Array(cardAchievements)
  }
}

extension Achievement {
  static let possibleAchievments = [
    Achievement(id: 1, prompt: "Syntax Error Grinds Class to a Halt"),
    Achievement(id: 2, prompt: "Tedious Slide Animation Repeat"),
    Achievement(id: 3, prompt: "Opening Comedy Bit Fails Miserably"),
    Achievement(id: 4, prompt: "Apologizes for Confusing Homework Instructions"),
    Achievement(id: 5, prompt: "Bails on Class Early for Weekend Flight"),
    Achievement(id: 6, prompt: "Instructor Says 'Rizz' or 'No Cap'")
  ]
}



