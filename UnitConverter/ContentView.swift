//
//  ContentView.swift
//  UnitConverter
//
//  Created by Peter Molnar on 12/10/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var originalValue = ""
    @State private var selectedInputMeasurement = 0
    @State private var selectedOutputMeasurement = 0
    
    let temperatureMeasurements = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedValue: Double {
        // TODO: The conversion logic here.
        0.0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter the original value", text: $originalValue)
                    Picker("Input measurement", selection: $selectedInputMeasurement) {
                        ForEach(0..<temperatureMeasurements.count) {
                            Text(self.temperatureMeasurements[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Converted value")) {
                    Text("\(convertedValue, specifier: "%.2f")")
                    Picker("Input measurement", selection: $selectedOutputMeasurement) {
                        ForEach(0..<temperatureMeasurements.count) {
                            Text(self.temperatureMeasurements[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationBarTitle("Unit Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
