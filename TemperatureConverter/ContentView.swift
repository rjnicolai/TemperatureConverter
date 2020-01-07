//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Rosanne Nicolai on 07/01/2020.
//  Copyright © 2020 Rosanne Nicolai. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputTempScale = 1
    @State private var outputTempScale = 1
    @State private var inputTemp = ""
    
    let inputTempScales = ["Celcius", "Fahrenheit", "Kelvin"]
    let outputTempScales = ["Celcius", "Fahrenheit", "Kelvin"]
    
    var calculateTemp: Double {
        let inputUnit = inputTempScales[inputTempScale]
        let outputUnit = outputTempScales[outputTempScale]
        let inputValue = Double(inputTemp) ?? 0
        
        var outputValue = Double(0)
        
        switch inputUnit {
        
        case "Celcius":
            switch outputUnit {
            case "Fahrenheit":
                outputValue = inputValue * 9/5 + 32
            case "Kelvin":
                outputValue = inputValue + 273.15
            default:
                outputValue = 0
            }
        case "Fahrenheit":
            switch outputUnit {
            case "Kelvin":
                outputValue = (inputValue + 459.67) * 5/9
            case "Celcius":
                outputValue = (inputValue - 32) * 5/9
            default:
                outputValue = 0
            }
        case "Kelvin":
            switch outputUnit {
            case "Fahrenheit":
                outputValue = (inputValue - 273.15) * 9/5 + 32
            case "Celcius":
                outputValue = inputValue - 273.15
            default:
                outputValue = 0
            }
        default:
            outputValue = 0
        }
        
        return Double(outputValue)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Select current temperature unit")) {
                    
                    Picker("Unit", selection: $inputTempScale) {
                        ForEach(0 ..< inputTempScales.count) {
                            Text(self.inputTempScales[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    
                    TextField("Temperature", text: $inputTemp)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Select temperature unit to convert to")) {
                    
                    Picker("Temperature scale", selection: $outputTempScale) {
                        ForEach(0 ..< outputTempScales.count) {
                            Text(self.outputTempScales[$0])
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Converted Temperature")) {
                        Text("\(calculateTemp, specifier: "%.1f") \(outputTempScales[outputTempScale])")
                }
            }
        .navigationBarTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
