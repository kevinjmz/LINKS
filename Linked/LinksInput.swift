//
//  LinksInput.swift
//  Linked
//
//  Created by Gerardo Cervantes on 11/3/16.
//  Copyright © 2016 Gerardo Cervantes. All rights reserved.
//

import UIKit



class LinksInput: UIViewController {
    
    
    /**Button handler provides more functionality to the buttons*/
    @IBOutlet var buttonHandler: ButtonHandler!
    
    
    /**Apply button, sends waci commands given the input and output buttons, inputs and outputs should be set in buttonHandler
     Sends waci command in the form: In3Out1, In3Out2, In4Out2.
     In(Input #)Out(Output #)   */
    @IBAction func changeInputOutput(_ sender: Button) {
        /**Finds what input is selected*/
        let inputNumber: Int? = findSelectedInput();
        

        /**No button was selected or waci command for selected buttons not properly set*/
        if inputNumber == nil {
            print("No input button selected or waci command not set properly, waci command should be an integer for input")
            return
        }
        
        
        /**Finds which outputs are selected and sends the waci commands accordingly to what is selected*/
        for button in buttonHandler.selectableButtons{
            if button.isSelected {
                buttonHandler.sendWaciCommand(waciCommand: "In\(inputNumber!)Out\(button.waciCommand!)")
            }
        }
        
    }
    
    /**Finds which input button is selected, find it by going through button handlers singleSelectable buttons*/
    private func findSelectedInput() -> Int?{

        var inputNumber: Int? = nil;
        
        for button in buttonHandler.singleSelectButtons {
            if button.isSelected {
                /**Converts waci command to integer*/
                if Int(button.waciCommand) != nil {
                    inputNumber = Int(button.waciCommand)!
                }
            }
        }
        
        return inputNumber
    }
    
}

