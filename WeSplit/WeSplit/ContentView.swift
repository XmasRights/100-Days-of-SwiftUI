//
//  ContentView.swift
//  WeSplit
//
//  Created by Christopher Fonseka on 27/11/2019.
//  Copyright © 2019 Christopher Fonseka. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        let peopleCount  = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentages[tipPercentage])
        let amountToPay  = Double(checkAmount) ?? 0

        let tipValue = amountToPay / 100 * tipSelection
        let grandTotal = amountToPay + tipValue
        return grandTotal / peopleCount
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<16) {
                            Text("\($0) people")
                        }
                    }
                }

                Section(header: Text("How much of a tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
