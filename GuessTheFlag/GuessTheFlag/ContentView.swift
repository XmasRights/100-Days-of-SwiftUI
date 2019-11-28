//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Christopher Fonseka on 28/11/2019.
//  Copyright © 2019 Christopher Fonseka. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let gradient = Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red])
    private var rainbow: AngularGradient { AngularGradient(gradient: gradient, center: .center) }

    var body: some View {
        ZStack {
            self.rainbow.frame(width: 400, height: 400).cornerRadius(200)
            Text("Hello World")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
