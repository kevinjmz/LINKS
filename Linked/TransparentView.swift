//
//  TransparentView.swift
//  Linked
//
//  Created by Gerardo Cervantes on 3/20/17.
//  Copyright © 2017 Gerardo Cervantes. All rights reserved.
//

import Foundation
import UIKit

class TransparentView: UIView {
    
    
    /**Extends UIView to handle what happens if the view is tapped.  If a view is tapped, and a subview wasn't tapped, then ignores the tap.*/
    
    /**Overrides point to decide whether it should handle the event, or whether view behind it should handle it*/
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        
        for subview in subviews {
            if !subview.isHidden && (subview.alpha > 0) && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
}
