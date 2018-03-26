//
//  Button.swift
//  Linked
//
//  Created by Gerardo Cervantes and Kevin Jimenez on 9/20/16 - 01/28/2018.
//  Copyright © 2016 Gerardo Cervantes & Kevin Jimenez. All rights reserved.
//

import UIKit

@IBDesignable class Button: UIButton {
    
    /**Every button has a label under the button, if no name for label is specified, then name is an empty string.
     
     Button properties added:
     
     label name - The name you want the label to be
     label size - Size you want label to be, this can be used to affect the label's position
     waci command - The waci command that will be sent.
     waci command released - Waci command to be sent for when no longer holding button.  Used for when user wants to hold a button down
     viewToDisplay - View that it should display if button is clicked
     view position - Position where you want view to be displayed at
     */
    
    
    /**TODO priority low: Set default of label width to be the same width as button*/
    
    
    /**Label displayed under button
     Bottom-left corner of button is top-left corner of label.
     Text position determined by the label width and height*/
    private var label: UILabel! = UILabel()
    
    @IBInspectable var shiftDown: CGFloat! = -20
    
    /**The button name that will be displayed, name will be displayed under the button using label: UILabel*/
    @IBInspectable var buttonLabel: String! = " " {
        didSet{label.text = buttonLabel}
    }
    
    /**The width and height of the label, can be used to adjust position of label*/
    @IBInspectable var labelSize: CGSize = CGSize(width: 110, height: 45) {
        didSet {
            label.frame = CGRect(x: 0,y: Int(self.frame.size.height), width: Int(labelSize.width), height: Int(labelSize.height)) //label.frame.width
        }
    }
    
    /**Command sent to waci, use ButtonHandler to send the command, connect the button to the waci method*/
    @IBInspectable var waciCommand: String! = "No command set"
    
    /**Command sent to waci after button is released, if blank then no command is sent*/
    @IBInspectable var waciCommandReleased: String! = "No command set for release"
    
    
    
    /**Name of the container you want to display when button is clicked, container's View Controller should also have the same name as the one you want to display*/
    @IBInspectable var viewToDisplay: String! = "No container to display set"
    
    /**Location you want container to be, if the container is added*/
    @IBInspectable var view: CGPoint = CGPoint(x: 0,y: 0)
  
    
    /**Sets initial settings for label*/
    private func setLabelSettings(){
        label.frame = CGRect(x: -20,y: self.frame.size.height-12, width: 110, height: 45)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        self.titleEdgeInsets = UIEdgeInsetsMake(110, 0, 0, 0) //down, right, ??, left   shift all buttons down
    }
    
    private func buttonShift (newValue:CGFloat,direction: Int){
        if(direction == -1){
        self.titleEdgeInsets = UIEdgeInsetsMake(newValue, 0, 0, 0)
        }
    }
    
    public func enableLabel(enable:Bool){
        //if color.alpha == 0.0 for toggle
        if enable {
            changeAlpha(newAlpha: 1.0)
        }
        else{
            changeAlpha(newAlpha: 0.0)
        }
    }
    
    private func changeAlpha( newAlpha: Float){
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: CGFloat(newAlpha))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setButtonLabel (value: CGFloat){
        //make the buttons content appear in the top-left
        self.contentVerticalAlignment = .bottom
        
        //move text 10 pixels down and right
        self.titleEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, value, 0.0)  //left , up,
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /**Hides original button title from showing up, the one that show up inside the button*/
        //setTitle(nil, for: UIControlState.normal)
        
        setLabelSettings()
        enableLabel(enable: false)
        self.addSubview(label)
        self.label.textAlignment = .center
        setButtonLabel(value: shiftDown)
        
    }
}
