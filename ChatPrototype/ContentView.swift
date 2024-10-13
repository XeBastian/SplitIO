//
//  ContentView.swift
//  ChatPrototype
//
//  Created by Ernest Sebastian on 12/10/2024.
//

import SwiftUI
 
struct ContentView: View {
    @State private var checkAmount: Double = 0.0
    @State private var numOfPeople: Int = 0
    @State private var tipPercentage: Int = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0,10,20,30,50,70,100]
    
    var totalPerPerson: Double{
        let peopleCount = Double (numOfPeople + 2)
        let tipSelection = Double (tipPercentage)
        
        let tipValue = (checkAmount / 100) * tipSelection
        let grandTotal = checkAmount + tipValue
        let grandTotalPerPerson = grandTotal / peopleCount
        return grandTotalPerPerson
    }
    
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    TextField("Ënter Check",  value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    
                    Picker("Split between", selection: $numOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    
                }
                Section("Select Tip Percentage"){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                Section{
                    Text("So \(Locale.current.currency?.identifier ?? "USD") \(String(format: "%.2f", checkAmount)), with \(numOfPeople+2) people and a \(tipPercentage) % tip, each Person pays")
                    Text(totalPerPerson,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.numberPad)
                }
            }.navigationTitle("SplitIO")
                .toolbar {
                    if(amountIsFocused){
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
