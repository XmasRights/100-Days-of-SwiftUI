//
//  ContentView.swift
//  ChallengeOne
//
//  Created by Christopher Fonseka on 08/12/2019.
//  Copyright © 2019 Christopher Fonseka. All rights reserved.
//

import SwiftUI

struct Conversion {
    let units: [String]
}

extension Conversion {
    static var temperature: Conversion {
        return .init(
            units: ["˚C", "˚F", "K"]
        )
    }
}

struct ContentView: View {
    @State private var amount = ""
    @State private var unitSelection = 0

    private let current = Conversion.temperature

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $amount)
                    Picker("Units", selection: $unitSelection) {
                        ForEach(0..<current.units.count) {
                            Text("\(self.current.units[$0])")
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
