//
//  ContentView.swift
//  SwiftUICalc
//
//  Created by Akash on 2023-06-05.
//

import SwiftUI

struct ContentView: View {
    @State private var displayText = ""
    let calcManager = CalcManager()
    
    let buttons = [
        ["","",operations.AC.rawValue,operations.backspace.rawValue],
        ["7", "8", "9", operations.devide.rawValue],
        ["4", "5", "6", operations.multiply.rawValue],
        ["1", "2", "3", operations.subtract.rawValue],
        ["0", ".", "=", operations.add.rawValue]
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Text(displayText)
                .font(.largeTitle)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()
                .opacity(0.7)
            
            ForEach(buttons, id: \.self) { row in
                HStack(spacing: 12) {
                    ForEach(row, id: \.self) { button in
                        Button(action: {
                            self.buttonTapped(button)
                        }) {
                            ButtonView(buttonValue: button,bgColor: colorPickerBasedOnType(str: button))
                        }
                    }
                }
                .padding(.bottom, 8)
                
            }
        }
        .background(Color.white)
    }
    
    func buttonTapped(_ button: String) {
        if button == "="{
            let str = String(calcManager.calculation())
            print("calc = \(str)")
            displayText = str
        }else if Int(button) != nil{
            displayText = calcManager.append(value: button)
        }else if let operation = operations(rawValue: button) {
            if operation == .backspace {
                displayText = calcManager.delete()
            } else if operation == .AC {
                displayText = calcManager.clearAll()
            }else{
                displayText = calcManager.set(operand: operation)
            }
        }
    }
    
    
    func colorPickerBasedOnType(str:String)->Color{
        if str == ""{
            return .white
        }
        let operation = operations(rawValue: str)
        if operation == .add || operation == .subtract || operation == .devide || operation == .multiply{
            return .black.opacity(0.6)
        }
        if operation == .AC || operation == .backspace {
            return .black.opacity(0.4)
        }
        if operation == nil && Int(str) != nil{
            return .orange
        }
        return .black.opacity(0.6)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ButtonView: View {
    var buttonValue:String
    var bgColor:Color
    var body: some View {
        Text(buttonValue)
            .font(.title)
            .foregroundColor(.white)
            .frame(width: self.buttonWidth(), height: self.buttonWidth())
            .background(bgColor)
            .cornerRadius(self.buttonWidth() / 2)
    }
    
    func buttonWidth() -> CGFloat {
        (UIScreen.main.bounds.width - 5 * 12) / 4
    }
}
