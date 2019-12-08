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

struct Value<UnitType> {
    let amount: Double
    let unit: UnitType

    var description: String {
        let formatted = String(format: "%.2f", amount)
        return "\(formatted)\(unit)"
    }
}

protocol Conversion {
    associatedtype UnitType: Unit

    var units: [UnitType] { get }
    func convert(value: Value<UnitType>, into: UnitType) -> Value<UnitType>
}

extension Conversion {
    func allConversions(for value: Value<UnitType>) -> [Value<UnitType>] {
        let units = self.units.filter {
            $0.description != value.unit.description
        }
        return units.map { convert(value: value, into: $0) }
    }
}

struct Temperature: Conversion {
    enum Units: String, Unit, CaseIterable {
        case celcius   = "˚C"
        case farenheit = "˚F"
        case kelvin    = "K"

        var description: String { self.rawValue }
    }

    var units: [Units] {
        Units.allCases
    }

    func convert(value: Value<Units>, into: Units) -> Value<Units> {
        // TODO
        .init(amount: 100, unit: .celcius)
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
