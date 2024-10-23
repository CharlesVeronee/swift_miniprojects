//
//  ContentView.swift
//  hw1-ctv5
//
//  Created by Charles Teague Veronee on 1/22/24.
//

import SwiftUI

struct ContentView: View {
    @State var cardLength = 3
    @State var cardEvents: [Achievement] = []
    var body: some View {
        VStack {
            Stepper("Number Of Events:" , value: $cardLength)
            Button("Get New Card: \(cardLength) Events") {createCard()}
            Text("Play Classroom Bingo")
                .font(.largeTitle)
            VStack {
                ForEach(cardEvents) { achievement in
                    HStack {
                        Button(achievement.prompt) {achievement.achieved.toggle()
                        }
                        Spacer()
                        choosePhoto(achievement: achievement)
                            .frame(width:20, height:20)
                        
                    }
                }
            }
            Spacer()
            yesBingo(bingoAchieved)
        }
        .padding()
    }
    
    func choosePhoto (achievement: Achievement) -> some View {
        if achievement.achieved {
            return Image(systemName: "checkmark")
        }
        else {
            return Image(systemName: "circle")
        }
        
    }
    
    func createCard () {
        cardEvents = Achievement.createCard(number:cardLength)
    }
    
    var bingoAchieved: Bool {
        cardEvents.filter{$0.achieved == true}.count >= cardLength
    }
    
    func yesBingo (_ bingoAchieved: Bool) -> Text {
        if bingoAchieved {
            return Text("BINGO!").foregroundColor(.red).font(.largeTitle).bold()
        }
        else {
            return Text("No Bingo Yet")
        }
        
        
    }
}




#Preview {
    ContentView()
}
