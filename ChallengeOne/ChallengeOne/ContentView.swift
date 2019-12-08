//
//  ContentView.swift
//  ChallengeOne
//
//  Created by Christopher Fonseka on 08/12/2019.
//  Copyright © 2019 Christopher Fonseka. All rights reserved.
//

import SwiftUI

protocol Unit {
    var description: String { get }
}

extension String: Unit {}

struct Value {
    let amount: Double
    let unit: Unit

    var description: String {
        let formatted = String(format: "%.2f", amount)
        return "\(formatted)\(unit)"
    }
}

protocol Conversion {
    var units: [Unit] { get }
}

struct Temperature: Conversion {
    var units: [Unit] {
        ["˚C", "˚F", "K"]
    }
}

struct ContentView: View {
    @State private var amount = ""
    @State private var unitSelection = 0

    private var current: some Conversion {
        Temperature()
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $amount)
                    Picker("Units", selection: $unitSelection) {
                        ForEach(0..<current.units.count) {
                            Text("\(self.current.units[$0].description)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("CNVRTR!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
