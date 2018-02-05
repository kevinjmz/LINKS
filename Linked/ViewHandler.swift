//
//  ViewHandler.swift
//  Linked
//
//  Created by Gerardo Cervantes on 3/2/17.
//  Copyright © 2017 Gerardo Cervantes. All rights reserved.
//

import Foundation
import UIKit

public class ViewHandler {
    
    /**Keeps track of views being shown and their associated view controllers*/
    
    
    /**Contains all subviews being displayed, if no subview is being displayed then should be empty
     Will be updated as long as addView and removeView functions are used to add or remove views*/
    private var viewsBeingDisplayed = Set<UIViewController>()
    
    init(){
    }
    
    /**Removes all child views from being shown.
     No subviews will be displayed after this is invoked
     @param childViewControllers are the all */
    public func removeAllChildViews(childViewControllers: [UIViewController]){
        
        for item in childViewControllers {
            
            if viewsBeingDisplayed.contains(item){
                removeView(viewToRemove: item, animate: true)
            }
            else{
                removeView(viewToRemove: item, animate: false)
            }
        }
        
        viewsBeingDisplayed.removeAll()
    }
    
    /**Removes all subviews from being shown that are in the viewsBeingDisplayed field
     @param fadeOutAnimation removes all views with an animation if true*/
    public func removeAllSubViews(fadeOutAnimate: Bool){
        
        for shownView in viewsBeingDisplayed {
            removeView(viewToRemove: shownView, animate: fadeOutAnimate)
        }
        
        viewsBeingDisplayed.removeAll()
    }
    
    /**Removes the given view from being shown
     @param animate if true removes view with a fading out animation*/
    public func removeView(viewToRemove: UIViewController, animate: Bool){
        
        viewsBeingDisplayed.remove(viewToRemove)
        
        if animate {
            //Animates the view fading out
            UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseOut], animations: {
                viewToRemove.view.alpha = CGFloat(1)
                }, completion: { (completed: Bool) in
                    viewToRemove.view.alpha = CGFloat(0)
                    viewToRemove.view.removeFromSuperview()
            })
        }
        else{
            viewToRemove.view.removeFromSuperview()
        }
    }
    
    /**Adds view as a subview (it will be displayed), takes in new position where it should be displayed
     @param view is the view you want to add the subview to
     @param viewControllerToAdd is the view's viewcontroller you want to add
     @param place is where you want to place the view using coordinates*/
    public func addView(view: UIView,viewControllerToAdd: UIViewController, place: CGPoint, fadeInAnim: Bool){
        
        let viewToDisplay: UIView = viewControllerToAdd.view
        viewsBeingDisplayed.insert(viewControllerToAdd)
        view.addSubview(viewToDisplay)
        viewToDisplay.center = place
        
        if fadeInAnim {
        viewToDisplay.alpha = CGFloat(0) //View fades in to being displayed
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut],   animations: {
                viewToDisplay.alpha = CGFloat(1)
            })
        }
    }
    
    /**Returns true if the view is currently being shown*/
    public func isShowing(viewToCheck: UIViewController) -> Bool {
        return viewsBeingDisplayed.contains(viewToCheck)
    }
    
    //Untested
    public func isShowing(viewToCheck: UIView) -> Bool {
        
        for viewDisplay in viewsBeingDisplayed{
            if viewDisplay.view.isEqual(viewToCheck){
                return true
            }
        }
        return false
    }
    
    /**Returns nil if no view is being shown, otherwise returns a view that is being shown*/
    public func getView() -> UIViewController? {
        return viewsBeingDisplayed.first
    }
    
}
