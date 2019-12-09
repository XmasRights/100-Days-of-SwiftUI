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

struct Value<UnitType: Unit> {
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
    enum Units: Unit, CaseIterable {
        case celcius
        case farenheit
        case kelvin

        var description: String {
            switch self {
            case .celcius:   return "˚C"
            case .farenheit: return "˚F"
            case .kelvin:    return "K"
            }
        }

        var converter: (Double, Self) -> Value<Self> {
            switch self {
            case .celcius:   return { self.convert(celcius: $0, as: $1)   }
            case .farenheit: return { self.convert(farenheit: $0, as: $1) }
            case .kelvin:    return { self.convert(kelvin: $0, as: $1)    }
            }
        }
    }

    var units: [Units] {
        Units.allCases
    }

    func convert(value: Value<Units>, into unit: Units) -> Value<Units> {
        let converter = value.unit.converter
        return converter(value.amount, unit)
    }
}

// MARK: Conversion Helpers

private extension Temperature.Units {
    func convert(celcius: Double, as unit: Self) -> Value<Self> {
        switch unit {
        case .celcius:
            return .init(amount: celcius, unit: .celcius)

        case .farenheit:
            let f = celcius * 1.8 + 32.0
            return .init(amount: f, unit: .farenheit)

        case .kelvin:
            let k = celcius + 273.15
            return .init(amount: k, unit: .kelvin)
        }
    }

    func convert(farenheit: Double, as unit: Self) -> Value<Self> {
        switch unit {
        case .celcius:
            let c = (farenheit - 32) / 1.8
            return .init(amount: c, unit: .celcius)

        case .farenheit:
            return .init(amount: farenheit, unit: .farenheit)

        case .kelvin:
            let k = (farenheit - 32) / 1.8 + 273.15
            return .init(amount: k, unit: .kelvin)
        }
    }

    func convert(kelvin: Double, as unit: Self) -> Value<Self> {
        switch unit {
        case .celcius:
            let c = kelvin - 273.15
            return .init(amount: c, unit: .celcius)

        case .farenheit:
            let f = (kelvin - 273.15) * 1.8 + 32.0
            return .init(amount: f, unit: .farenheit)

        case .kelvin:
            return .init(amount: kelvin, unit: .kelvin)
        }
    }
}

struct AnyValue {
    var description: String

    init<U: Unit>(_ value: Value<U>) {
        self.description = value.description
    }
}

struct ContentView: View {
    @State private var amount = ""
    @State private var unitSelection = 0

    private var current: some Conversion {
        Temperature()
    }

    private var conversions: [AnyValue] {
        let amount = Double(self.amount) ?? 0.0
        let unit = current.units[unitSelection]
        let value = Value(amount: amount, unit: unit)
        return current.allConversions(for: value).map(AnyValue.init)
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

                Section {
                    ForEach(0..<conversions.count) {
                        Text("\(self.conversions[$0].description)")
                    }
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
