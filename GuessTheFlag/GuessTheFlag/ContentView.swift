//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Christopher Fonseka on 28/11/2019.
//  Copyright © 2019 Christopher Fonseka. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var countries = ["estonia", "france", "germany", "ireland", "italy", "nigeria", "poland", "russia", "spain", "uk", "us"].shuffled()

    var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer].capitalized)
                    .foregroundColor(.white)
                }

                ForEach(0..<3) { number in
                    Button(action: {
                        // Flag was tapped
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }
                }

                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
