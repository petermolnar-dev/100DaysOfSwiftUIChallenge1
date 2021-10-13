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
    
    var originalValueNumber: Double {
        Double(originalValue) ?? 0
    }
    
    func unit(from selectedMeasurement: Int) -> UnitTemperature {
        switch selectedMeasurement {
        case 1:
            return UnitTemperature.fahrenheit
        case 2:
            return UnitTemperature.kelvin
        default:
            return UnitTemperature.celsius
        }
    }
    
    func convertToKelvin(value: Double, fromUnit: UnitTemperature) -> Double {
        if fromUnit == UnitTemperature.celsius {
            return value + 273.15
        }
        if fromUnit == UnitTemperature.fahrenheit {
            return (value * 0.55555555555556) + 255.37222222222427
        }
        return value
    }
    
    func convertFromKelvin(value: Double, toUnit: UnitTemperature) -> Double {
        if toUnit == UnitTemperature.celsius {
            return value - 273.15
        }
        if toUnit == UnitTemperature.fahrenheit {
            return (value - 255.37222222222427) / 0.55555555555556
        }
        return value
    }
    
    func convert(value: Double, fromUnit: UnitTemperature, toUnit: UnitTemperature) -> Double {
        if fromUnit == toUnit {
            return value
        }
        let kelvinValue = convertToKelvin(value: value, fromUnit: fromUnit)
        let convertedValue = convertFromKelvin(value: kelvinValue, toUnit: toUnit)
        return convertedValue
    }
    
    var convertedValue: String {
        let originalUnit = unit(from: selectedInputMeasurement)
        let convertedUnit = unit(from: selectedOutputMeasurement)
        let convertedValue = convert(value: originalValueNumber,
                                     fromUnit: originalUnit,
                                     toUnit: convertedUnit)
        let originalMeasure = Measurement(value: convertedValue, unit: convertedUnit)
        return originalMeasure.description
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
                    Text("\(convertedValue)")
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
