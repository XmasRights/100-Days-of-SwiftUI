//
//  ContentView.swift
//  BetterRest
//
//  Created by Christopher Fonseka on 27/04/2020.
//  Copyright © 2020 christopherfonseka. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var wakeUp = Date()
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertShowing = false

    var body: some View {
        NavigationView {
            VStack {
                Text("When do you want to wake up")

                DatePicker("Select a time",
                           selection: $wakeUp,
                           displayedComponents: .hourAndMinute)
                .labelsHidden()

                Text("Desired amount of sleep")
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }

                Text("Daily Coffee Intake")
                Stepper(value: $coffeeAmount, in: 1...20) {
                    if coffeeAmount == 1 {
                        Text("1 cup")
                    } else {
                        Text("\(coffeeAmount) cups")
                    }
                }

            }

            .navigationBarTitle("BetterRest")
            .navigationBarItems(trailing:
                Button("Calculate", action: calculateBedtime)
            )
                .alert(isPresented: $alertShowing) {
                    Alert(title: Text(alertTitle),
                          message: Text(alertMessage),
                          dismissButton: .default(Text("Good Night")))
            }
        }
    }

    func calculateBedtime() {
        let model = SleepCalculator()
        print("Calculate")

        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minutes = (components.minute ?? 0) * 60

        do {
            let prediction = try model.prediction(wake: Double(hour + minutes),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep

            let formatter = DateFormatter()
            formatter.timeStyle = .short

            alertTitle = "Please Go To Bed At"
            alertMessage = formatter.string(from: sleepTime)

        } catch {
            alertTitle = "Error"
            alertMessage = "Something went very wrong"
        }

        alertShowing = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

