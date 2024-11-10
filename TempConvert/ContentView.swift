//
//  ContentView.swift
//  TempConvert
//
//  Created by Ricky Ariansyah on 11/11/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var temp: Double = 0.0
    @State private var fromTemp: String = "Kelvin"
    @State private var toTemp: String = "Kelvin"
    
    let selectionTemp = ["Kelvin", "Celcius", "Fahrenheit", "Reamur"]
    
    var convResult: Double {
        if(fromTemp == toTemp) {
            return temp
        }
        
        if(fromTemp == "Celcius") {
            switch(toTemp){
            case "Kelvin":
                return temp + 273
            case "Reamur":
                return 4/5 * temp
            case "Fahrenheit":
                return (9/5 * temp) + 32
            default:
                return temp
            }
        } else if (fromTemp == "Kelvin") {
            switch(toTemp){
            case "Celcius":
                return temp - 273
            case "Reamur":
                return 4/5 * (temp - 273)
            case "Fahrenheit":
                return (9/5 * (temp - 273)) + 32
            default:
                return temp
            }
        } else if (fromTemp == "Reamur") {
            switch(toTemp){
            case "Celcius":
                return 5/4 * temp
            case "Kelvin":
                return (5/4 * temp) + 273
            case "Fahrenheit":
                return (9/4 * temp ) + 32
            default:
                return temp
            }
        } else if (fromTemp == "Fahrenheit") {
            switch(toTemp){
            case "Celcius":
                return 5/9 * (temp - 32)
            case "Kelvin":
                return 5/9 * (temp - 32) + 273
            case "Reamur":
                return 4/9 * (temp - 32)
            default:
                return temp
            }
        }
        
        return temp
    }
    
    func formattedNumber(_ value: Double) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.groupingSeparator = ","
            formatter.groupingSize = 3
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 0
            
            return formatter.string(from: NSNumber(value: value)) ?? ""
        }

    var body: some View {
        NavigationView {
            Form {
                Section{
                    Picker("From To", selection: $fromTemp) {
                        ForEach(selectionTemp, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.navigationLink)
                    TextField("Insert Value", value: $temp, format: .number)
                    Picker("Convert To", selection: $toTemp) {
                        ForEach(selectionTemp, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section("Result"){
                   Text(" \(formattedNumber(convResult))")
                }
            }.navigationTitle("Temp Conversion")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

}



#Preview {
    ContentView()
}
