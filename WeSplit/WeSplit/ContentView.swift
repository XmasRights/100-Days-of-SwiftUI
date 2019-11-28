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
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 2

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalToPay: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let amountToPay  = Double(checkAmount) ?? 0

        let tipValue = amountToPay / 100 * tipSelection
        return amountToPay + tipValue
    }

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople) ?? 1
        return totalToPay / peopleCount
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Number of people", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("How much of a tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Total to pay ")) {
                    Text("$\(totalToPay, specifier: "%.2f")")
                }

                Section(header: Text("Amount per person")) {
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
