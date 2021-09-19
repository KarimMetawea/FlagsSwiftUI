//
//  ContentView.swift
//  FlagsApp
//
//  Created by Karem on 9/19/21.
//

import SwiftUI

struct ContentView: View {
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    @State private var isCorrectAnswer = false
    @State private var showAlert = false
    @State var currentScore = 0
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .bottom, endPoint: .trailing).ignoresSafeArea()
            VStack{
                Spacer()
                VStack {
                    Text("Select the flag of ")
                    Text(countries[correctAnswer]).font(.largeTitle).fontWeight(.bold)
                }.foregroundColor(.white)
                
                VStack{
                    ForEach(0..<3){ number in
                        Button(action: {
                           flagTapped(number: number)
                        }, label: {
                            Image(self.countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.black))
                                .shadow(color: .black, radius: 5, x: 0, y: 0)
                        })
                    }
                }
                Spacer()
            }
        }.alert(isPresented: $showAlert, content: {
            Alert(title: Text(isCorrectAnswer ? "Correct":"Wrong"), message: Text("your score is \(currentScore)"), dismissButton:.default(Text("Continue"), action: {
                self.refresh()
            }))
        })
        
        
    }
    
    
    func flagTapped(number:Int){
        self.isCorrectAnswer = number == correctAnswer
        currentScore = isCorrectAnswer ? (currentScore + 1) : (currentScore > 0 ? (currentScore - 1):0)
        self.showAlert = true
    }
    
    func refresh(){
        self.countries.shuffle()
        self.correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
