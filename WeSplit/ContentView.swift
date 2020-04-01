//
//  ContentView.swift
//  WeSplit
//
//  Created by Cathal Farrell on 20/03/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

 /*
     Views & Modifiers - Challenge 2
     Go back to project 1 and use a conditional modifier to change the total amount text view
     to red if the user selects a 0% tip.
 */

import SwiftUI

struct ContentView: View {

    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentageIndex = 2

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {

        let peopleCount = Double(numberOfPeople) ?? 0
        let tipPercentage = Double(tipPercentages[tipPercentageIndex]) / 100
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount  * tipPercentage
        let grandTotal = orderAmount + tipValue

        if peopleCount > 0 {
            let amountPerPerson = grandTotal / peopleCount
            return amountPerPerson
        } else {
            return 0
        }
    }

    var tipAmount: Double {

        let tipPercentage = Double(tipPercentages[tipPercentageIndex]) / 100
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount  * tipPercentage

        return tipValue
    }

    var totalBillAmount: Double {

        let tipPercentage = Double(tipPercentages[tipPercentageIndex]) / 100
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount  * tipPercentage
        let grandTotal = orderAmount + tipValue

        return grandTotal
    }

    var body: some View {
        NavigationView {
            Form{
                Section {
                    TextField("Enter Bill Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    TextField("Enter Number of People Splitting the Bill", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                Section(header:Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentageIndex) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }

                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Tip Amount")) {
                                   Text("€\(tipAmount, specifier: "%.2f")")

                               }
                Section(header: Text("Bill Total")) {
                    Text("€\(totalBillAmount, specifier: "%.2f")")
                    //Challenge 2
                    .foregroundColor(tipAmount > 0 ? Color.black : Color.red)
                }
                Section(header: Text("Amount per person")) {
                    Text("€\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
