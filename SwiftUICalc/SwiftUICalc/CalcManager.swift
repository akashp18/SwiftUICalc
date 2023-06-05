//
//  CalcManager.swift
//  SwiftUICalc
//
//  Created by Akash on 2023-06-05.
//

import Foundation

class CalcManager{
    var value1 = 0
    var value2 = 0
    var currentOperand:operations?
    var values:[String] = []
    
    func insert(value:Int){
        if value1 == 0{
            value1 = value
        }else{
            value2 = value
        }
    }
    
    func set(operand:operations)->String{
        currentOperand = operand
        setValues()
        return values.joined()
    }
    
    func append(value:String)->String{
        values.append(value)
        return values.joined()
    }
    
    func clearAll()->String{
        values.removeAll()
        value1 = 0
        value2 = 0
        return values.joined()
    }
    
    func setValues(){
        guard let intValue = Int(values.joined()) else{return}
        insert(value: intValue)
        values = []
    }
    
    func delete()->String{
        if !values.isEmpty{
            values.removeLast()
        }
        return values.joined()
    }
    
    func calculation()->Int{
        setValues()
        var ans = 0
        guard let currentOperand = currentOperand else {fatalError()}
        switch currentOperand {
        case .add:
            ans =  value1 + value2
        case .subtract:
            ans = value1 - value2
        case .multiply:
            ans = value1 * value2
        case .devide:
            ans = value1 / value2
        default:
            fatalError()
        }
        value1 = ans
        value2 = 0
        return ans
    }
}
