//
//  ContentView.swift
//  BetterRest
//
//  Created by Christopher Fonseka on 27/04/2020.
//  Copyright © 2020 christopherfonseka. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0

    var body: some View {
        Stepper(value: $sleepAmount, in: 4...24, step: 0.25) {
            Text("\(sleepAmount) hours")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

