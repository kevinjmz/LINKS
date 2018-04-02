//
//  ButtonHandler.swift
//  Linked
//
//  Created by Gerardo Cervantes and Kevin Jimenez on 9/20/16- 01/28/2018.
//  Copyright © 2016 Gerardo Cervantes and Kevin Jimenez. All rights reserved.
//

import Foundation
import UIKit

class ButtonHandler: NSObject  {
    
    /** Button Handler help gives buttons more functionality by being able to send waci commands through them, make buttons selectable, and being able to hide a collection of buttons.
     */
    
    /**Used to send messages to waci when button is clicked*/
    private final let waci = Waci()
    
    
    /**Button collection used to hide or show a group of button at the same time*/
    @IBOutlet var hidingButtons: [Button]!
    
    /**Only 1 button can be selected at a time if from this collection*/
    @IBOutlet var singleSelectButtons: [Button]!
    
    /**Contains buttons that can be selected.
     Used to find which buttons are selected*/
    @IBOutlet var selectableButtons: [Button]!
    
    
    /**Sends Waci Command,
     command being sent should be set in attribute inspector of the button in storyboard*/
    @IBAction func sendWaciCommand(_ sender: Button) {
        waci.sendWaciCommand(waciCommand: sender.waciCommand)
    }
    
    /**Command to be sent when waci command is released*/
    @IBAction func sendWaciCommandRelease(_ sender: Button) {
        waci.sendWaciCommand(waciCommand: sender.waciCommandReleased)
    }
    
    @IBOutlet weak var CameraPreset: Button!

    @IBOutlet weak var SourcePC: Button!
    
    @IBOutlet weak var ClassroomMode: Button!
    
    @IBOutlet weak var VCMode: Button!
    
    @IBOutlet weak var MainComputer_left: Button!
    
    @IBOutlet weak var Laptop_left: Button!
    
    @IBOutlet weak var AppleTV_left: Button!
    
    
    @IBOutlet weak var MainComputer_right: Button!
    
    @IBOutlet weak var Laptop_right: Button!
    
    @IBOutlet weak var AppleTV_right: Button!
    
    @IBOutlet weak var TurnOff_right:Button!
    @IBOutlet weak var TurnOn_right:Button!
    @IBOutlet weak var TurnOff_left:Button!
    @IBOutlet weak var TurnOn_left:Button!
    
    @IBOutlet weak var numpadC: UIViewController!
    
    var leftIsEnabled = false;
    var rightIsEnabled = false;
    
    @IBAction public func TurnOffRightTapped (_ sender:Button){
        TurnOff_right.isHidden = true
        TurnOn_right.isHidden = false
    }
    @IBAction public func TurnOffLeftTapped (_ sender:Button){
        TurnOff_left.isHidden = true
        TurnOn_left.isHidden = false
    }
    @IBAction public func TurnOnRightTapped(_ sender:Button){
        TurnOff_right.isHidden = false
        TurnOn_right.isHidden = true
    }
    
    @IBAction public func TurnOnLeftTapped(_ sender:Button){
        TurnOff_left.isHidden = false
        TurnOn_left.isHidden = true
    }
    
    @IBAction public func CloseBtnTapped (_ sender: Button){
        numpadC.dismiss(animated: true, completion: nil)
    }
    
    @IBAction public func classroomModeTapped (_ sender: Button){
        //VCMode.isEnabled = true
        ClassroomMode.isEnabled = false
        SourcePC.isEnabled = false
        CameraPreset.isEnabled = false
    }
    
    @IBAction public func VCModeTapped (_ sender:Button){
        //VCMode.isEnabled = false
        ClassroomMode.isEnabled = true
        SourcePC.isEnabled = true
        CameraPreset.isEnabled = true
    }
    
    @IBAction public func LeftProjectorTapped (_ sender:Button){
        if(leftIsEnabled == false){
        //display corresponding buttons
        MainComputer_left.isHidden = false
        Laptop_left.isHidden = false
        AppleTV_left.isHidden = false
            leftIsEnabled = true
        }
        else{
            MainComputer_left.isHidden = true
            Laptop_left.isHidden = true
            AppleTV_left.isHidden = true
            leftIsEnabled = false
        }
    }
    @IBAction public func RightProjectorTapped (_ sender:Button){
        if(rightIsEnabled == false){
            //display corresponding buttons
            MainComputer_right.isHidden = false
            Laptop_right.isHidden = false
            AppleTV_right.isHidden = false
            rightIsEnabled = true
        }
        else{
            MainComputer_right.isHidden = true
            Laptop_right.isHidden = true
            AppleTV_right.isHidden = true
            rightIsEnabled = false
        }
    }
    
    /**Sends waci command with given string*/
    func sendWaciCommand(waciCommand: String) {
        waci.sendWaciCommand(waciCommand: waciCommand)
    }
    
    /**If buttons is in selected state, changes it's state back to nonselected.
     If not in selected state, changed the button to selected and unselects everything else*/
    @IBAction func buttonSingleSelect(_ sender: Button) {
        if(sender.isSelected){
            sender.isSelected = false
            return
        }
        for inputDevice in singleSelectButtons {
            inputDevice.isSelected = false
        }
        sender.isSelected = true
    }
    
    /**Toggles the selected state of a button*/
    @IBAction func changeSelectState(_ sender: Button) {
        sender.isSelected = !sender.isSelected
    }
    
    /**Toggles between hiding buttons that are in the hidingButtons collection*/
    private func buttonVisibilityToggle(){
        for button in hidingButtons {
            button.isHidden = !button.isHidden
        }
    }
    
    /**Hides or unhides button given array of buttons*/
    private func buttonVisibility(buttons: [Button]!, hide: Bool){
        for button in buttons {
            button.isHidden = hide
        }
    }
}
