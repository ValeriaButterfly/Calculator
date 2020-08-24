//
//  ViewController.swift
//  Calculator
//
//  Created by Valeria Muldt on 12/04/2019.
//  Copyright © 2019 Valeria Muldt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayResultLable: UILabel!
    var stillTyping = false
    var dotIsPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    var currentInput: Double {
        get {
            return Double(displayResultLable.text!)!
        }
        
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                displayResultLable.text = "\(valueArray[0])"
            } else {
                displayResultLable.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    @IBAction func numberPressed(_ sender: UIButton) {
        
        let number = sender.currentTitle!
//        print(number)
        
        if stillTyping {
//            if displayResultLable.text!.characters.count < 20 {
//                displayResultLable.text = displayResultLable.text! + number
//            }
            if displayResultLable.text!.count < 20 {
                displayResultLable.text = displayResultLable.text! + number
            }
        } else {
            displayResultLable.text = number
            stillTyping = true
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
//        print(firstOperand)
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperands(operation: (Double, Double) -> Double) {
        currentInput = operation(firstOperand, secondOperand)
        stillTyping = false
    }
    
    @IBAction func resultOperation(_ sender: UIButton) {
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "+":
            operateWithTwoOperands{$0 + $1}
        case "-":
            operateWithTwoOperands{$0 - $1}
        case "×":
            operateWithTwoOperands{$0 * $1}
        case "÷":
            operateWithTwoOperands{$0 / $1}
        default:
            break
        }
    }
    
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLable.text = "0"
        stillTyping = false
        dotIsPlaced = false
        operationSign = ""
    }
    @IBAction func plusMinusButtonPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    @IBAction func procentButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
        }
        stillTyping = false
    }
    @IBAction func sqrtButtonPressed(_ sender: UIButton) {
        
        if currentInput < 0 {
            displayResultLable.text = "Error"
        } else {
            currentInput = sqrt(currentInput)
        }
    }
    @IBAction func pointButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLable.text = displayResultLable.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResultLable.text = "0."
        }
    }
}

