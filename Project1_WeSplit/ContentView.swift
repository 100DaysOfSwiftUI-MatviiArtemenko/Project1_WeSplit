//
//  ContentView.swift
//  Project1_WeSplit
//
//  Created by admin on 02.08.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var amountToPay = 0.0
    @State private var peopleToSplitFor = 1
    @State private var tip = [5,10,15,20,25,30,35,40,45,50,55,60,65,70]
    @State private var tipChoice = 0
    
    @FocusState private var isFocused
    
    var calculatedSum: Double {
        let tip = Double(tipChoice)
        let tipValeue = amountToPay / 100 * tip
        return amountToPay + tipValeue
    }
    
    var sumDividedPerPerson : Double {
        let peopleToSplitFor = Double(peopleToSplitFor + 1)
        let tip = Double(tipChoice)
        let tipValeue = amountToPay / 100 * tip
        let fullSum = amountToPay + tipValeue
        return fullSum / peopleToSplitFor
    }
        
    var body: some View {
        NavigationView {
            ZStack {
                Color(.init(red: 0.7, green: 0.5, blue: 0.4, alpha: 1))
                    .ignoresSafeArea()
                VStack(alignment: .center) {
                    Spacer()
                    Text("Amount to pay")
                        .foregroundColor(.black)
                        .font(.title.weight(.bold))
                    TextField(" Write the amout to pay", value: $amountToPay, format: .currency(code: Locale.current.currencyCode ?? " USD")).padding(.horizontal)
                        .keyboardType(.decimalPad)
                        .font(.headline)
                        .focused($isFocused)
                        .frame(width: UIScreen.main.bounds.width/1.25, height: 80)
                        .background(.regularMaterial)
                        .cornerRadius(10)
                    
                    
                    HStack(spacing: 20) {
                        VStack {
                            Text("Split for")
                                .foregroundColor(.black)
                                .font(.title2.weight(.bold))
                            
                            HStack {
                                
                                Picker("Split for", selection: $peopleToSplitFor) {
                                    ForEach(1..<50) {
                                        Text("\($0) ppl")
                                    }
                                }
                                .pickerStyle(.menu)
                                .frame(width: UIScreen.main.bounds.width/3, height: 60, alignment: .center)
                                .background(.regularMaterial)
                                .cornerRadius(10)
                            }
                        }
                        VStack {
                            Text("Leave a tip")
                                .foregroundColor(.black)
                                .font(.title2.weight(.bold))
                            
                            HStack {
                                
                                Picker("Leave a tip", selection: $tipChoice) {
                                    ForEach(tip, id: \.self) {
                                        Text($0, format: .percent)
                                        
                                    }
                                }
                                .pickerStyle(.menu)
                                .frame(width: UIScreen.main.bounds.width/3, height: 60, alignment: .center)
                                .clipped()
                                .compositingGroup()
                                .background(.regularMaterial)
                                .cornerRadius(10)
                            }
                        }
                    }
                    .foregroundColor(.white)
                    Spacer()
                    Spacer()
                    
                    
                    VStack(spacing: 20) {
                        HStack {
                            Text("Total sum")
                            Spacer()
                            Text(calculatedSum, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                .padding(.trailing)
                        }
                        HStack {
                            Text("Per single person")
                            Spacer()
                            Text(sumDividedPerPerson,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                                .padding(.trailing)
                        }
                    }
                    .font(.title2.weight(.semibold))
                    .frame(width: .infinity, height: .infinity, alignment: .center)
                    .ignoresSafeArea()
                    .padding(.bottom)
                    .padding([.all, .top])
                    .background(.regularMaterial)
                    .shadow(radius: 10, y: -1)
                    
                    
                }
            }
        }
        .preferredColorScheme(.dark)
        .accentColor(.white)
        
        .toolbar{
            ToolbarItemGroup(placement: .keyboard) {
                Button("Done"){
                    isFocused = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
