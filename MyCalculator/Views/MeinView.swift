//
//  MeinView.swift
//  MyCalculator
//
//  Created by Виктория Демченко on 04.12.23.
//

import SwiftUI

struct MeinView: View {
    
    //MARK: Prorerty
    @State private var value = "0"
    @State private var number: Double = 0.0
    @State private var currentOperation: Operation = .none
    
    let buttonsArray: [[Buttons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equel]
    ]
    
    var body: some View {
        
        ZStack {
            // MARK: Background
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                
                //MARK: Display
                
                Spacer()
                HStack {
                    Spacer()
                    Text(value)
                        .foregroundColor(.white)
                        .font(.system(size: 90))
                        .fontWeight(.light)
                        .padding(.horizontal, 25)
                    
                }
                
                //MARK: Buttons
                ForEach(buttonsArray, id: \.self) { row in
                    HStack(spacing: 12)  {
                        ForEach(row, id: \.self) { item in
                            Button{
                                self.didTap(item: item)
                            } label: {
                                    Text(item.rawValue)
                                    .frame(
                                        width: self.buttonWidth(item: item),
                                        height: self.buttonHeight())
                                    .foregroundColor(item.buttonFontColor)
                                    .background(item.buttonColor)
                                    .font(.system(size: 35))
                                    .cornerRadius(40)
                            }
                        }
                    }
                }
            }
            .padding(.bottom)
        }
    }
    
    //MARK: Tap Button Method
    func didTap(item: Buttons){
        switch item {
        case .plus:
            currentOperation = .addition
            number = Double(value) ?? 0
            value = "0"
        case .minus:
            currentOperation = .subtract
            number = Double(value) ?? 0
            value = "0"
        case .multiply:
            currentOperation = .multiply
            number = Double(value) ?? 0
            value = "0"
        case .divide:
            currentOperation = .divide
            number = Double(value) ?? 0
            value = "0"
        case .equel:
            if let currentValue = Double(value){
                value = String(performOperation(currentValue))
            }
        case .decimal:
            if !value.contains("."){
                value += "."
            }
        case .percent:
            if let currentValue = Double(value){
                value = String(currentValue / 100)
            }
        case .negative:
            if let currentValue = Double(value){
                value = String(-currentValue)
            }
        case .clear:
            value = "0"
        default:
            if value == "0"{
                value = item.rawValue
            } else {
                value += item.rawValue
            }
        }
    }
    
    //MARK: Halper Calculate Method
    func performOperation(_ currentValue: Double)-> Double {
        switch currentOperation {
        case .addition:
            return number + currentValue
        case .subtract:
            return number - currentValue
        case .multiply:
            return number * currentValue
        case .divide:
            return number / currentValue
        default:
            return currentValue
        }
    }
    
    //MARK: Size of Buttons Methods
    func buttonWidth(item: Buttons) -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let zeroTotalSpacing: CGFloat = 4 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        
        if item == .zero{
            return (screenWidth - zeroTotalSpacing) / totalColumns * 2
        }
            return (screenWidth - totalSpacing) / totalColumns
        }
    
    func buttonHeight() -> CGFloat {
        let spacing: CGFloat = 12
        let totalSpacing: CGFloat = 5 * spacing
        let totalColumns: CGFloat = 4
        let screenWidth = UIScreen.main.bounds.width
        return (screenWidth - totalSpacing) / totalColumns
    }
}

#Preview {
    MeinView()
}
