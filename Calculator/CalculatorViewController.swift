//
//  CalculatorViewController.swift
//  Calculator
//
//  Created by Chirag Bhutani on 10/05/20.
//  Copyright © 2020 Chirag Bhutani. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    var currentNumberOnScreen : Double = 0
    var previousNumber :Double = 0
    var isPerformingOperation = false
    var operation = 0
    
    var memoryNumber : Double = 0
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var btnReadMemory: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        resultLabel.text = "0"
    }
    
    @IBAction func onNumberTapped(_ sender: UIButton) {
        
        if isPerformingOperation == true{
            let resultString = String(sender.tag-1)
            currentNumberOnScreen = Double(resultString)!
            resultLabel.text = formatResultString(resultNumber: currentNumberOnScreen)
            isPerformingOperation = false
        }
        else{
            let resultString = resultLabel.text! + String(sender.tag - 1)
            currentNumberOnScreen = Double(resultString)!
            resultLabel.text = formatResultString(resultNumber: currentNumberOnScreen)
        }
    }
    
    @IBAction func onDotTapped(_ sender: UIButton) {
        
        if (resultLabel.text?.contains("."))!{
           return
        }
        
        if isPerformingOperation == true{
            resultLabel.text = "0."
            currentNumberOnScreen = Double(resultLabel.text!)!
            isPerformingOperation = false
        }
        else{
            resultLabel.text = resultLabel.text! + "."
            currentNumberOnScreen = Double(resultLabel.text!)!
        }

    }
    
    
    @IBAction func onOperatorTapped(_ sender: UIButton) {
        

        // tag 15 for clean and 21 for equals
        if resultLabel.text != "" && sender.tag != 15 && sender.tag != 21{
            
            if let previousNumberCurrent = Double(resultLabel.text!){
                previousNumber = previousNumberCurrent
            }

            if sender.tag == 16{ //plus minus
                let currentNumberOnResultLabel = Double(resultLabel.text!)
                currentNumberOnScreen = -1 * currentNumberOnResultLabel!
                resultLabel.text = formatResultString(resultNumber: currentNumberOnScreen)
            }
            if sender.tag == 17{ //divide
                resultLabel.text = "/"
            }
            else if sender.tag == 18{ //multiply
                resultLabel.text = "x"

            }
            else if sender.tag == 19{ // subtract
                resultLabel.text = "-"

            }
            else if sender.tag == 20{ // add
                
                resultLabel.text = "+"
            }
            operation = sender.tag
            isPerformingOperation = true
        }
        else if sender.tag == 21{
            
            if operation == 17{ // divide
                let resultOfCalculation = previousNumber / currentNumberOnScreen
                resultLabel.text = formatResultString(resultNumber: resultOfCalculation)
            }
            else if operation == 18{ // multiply
                let resultOfCalculation = previousNumber * currentNumberOnScreen
                resultLabel.text = formatResultString(resultNumber: resultOfCalculation)
            }
            else if operation == 19{ // subtract
                let resultOfCalculation = previousNumber - currentNumberOnScreen
                resultLabel.text = formatResultString(resultNumber: resultOfCalculation)
            }
            else if operation == 20{ // add
                let resultOfCalculation = previousNumber + currentNumberOnScreen
                resultLabel.text = formatResultString(resultNumber: resultOfCalculation)
            }
        }
        else if sender.tag == 15{
            resultLabel.text = "0"
            previousNumber = 0
            currentNumberOnScreen = 0
            operation = 0
        }
    }
    
    @IBAction func onMemoryOperatorTapped(_ sender: UIButton) {
        
        if sender.tag == 11 { // MC
            memoryNumber = 0
            btnReadMemory.backgroundColor = sender.backgroundColor
        }
        else if sender.tag == 12 { // M+
            
            if let numberOnScreen = Double(resultLabel.text!){
                memoryNumber = memoryNumber + numberOnScreen
                btnReadMemory.backgroundColor = UIColor.systemGreen
            }
        }
        else if sender.tag == 13 { // M-
            if let numberOnScreen = Double(resultLabel.text!){
                memoryNumber = memoryNumber - numberOnScreen
                btnReadMemory.backgroundColor = UIColor.systemGreen
            }
        }
        else if sender.tag == 14 { // MR
            
            resultLabel.text = formatResultString(resultNumber: memoryNumber)
//            resultLabel.text = String(memoryNumber)
            currentNumberOnScreen = memoryNumber
            isPerformingOperation = false
        }
    }
    
    private func formatResultString(resultNumber : Double) -> String{
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 8

        if let strResult = formatter.string(from: NSNumber(value: resultNumber)){
            return strResult
        }
        else{
            return ""
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
