//
//  LinksContainer.swift
//  Linked
//
//  Created by Gerardo Cervantes & Kevin Jimenez.
//  Copyright © 2018 Gerardo Cervantes and Kevin Jimenez. All rights reserved.
//

import UIKit



class LinksHub: UIViewController {
    
    //TODO create new folder to put all the subview view controller classes
    
    /**Views are removed and added using ViewHandler.
     
     When a button is clicked, it finds the view associated with the button by looking through the childViewControllers to see if one has the same name as the button's viewToDisplay field.  If a view associated with button is not found then ignores the button click.
     
     If the view was already being displayed, then removes the view from being displayed and removes it from being a subview.
     If the view was not already being displayed, then adds the view as a subview and starts displaying it
     */
    
    
    /**Contains all subviews being displayed, if no subview is being displayed then should be empty
     Will be updated as long as addView and removeView functions are used to add or remove views*/
    
    /**ViewHandler is used to display, and remove views from being shown*/
    private let viewHandler: ViewHandler = ViewHandler();
    
    /**Used to show animations*/
    private let animation: Animation = Animation()
    
    private let backgroundView = UIImageView(frame: UIScreen.main.bounds)
    
    private let defaultBackground: UIImage? = UIImage(named: "GridBackground.jpg")
    
    @IBOutlet weak var CameraAnimator: AnimationCameraView!
    
    @IBOutlet weak var MenuAnimator: AnimationMenuView!

    @IBOutlet weak var InputAnimator: InputAnimationView!
    
    @IBOutlet weak var VolumeAnimator: VolumeAnimationView!
    
    /*Similar to a toggle, if a view you want to display is already being displayed removes the view.
     if a view was already being displayed then removes views and then adds the new view*/
    //Ex.  Menu view is being shown, if menu button is clicked again, then it hides the menu view
    /**Uses Button's viewToDisplay field to find a viewController with same name, if it finds it, then toggles the view from being shown*/
    @IBAction func displayContainer(_ sender: Button) {
        let viewControllerToDisplay: UIViewController? = findViewController(viewName: sender.viewToDisplay)
        
        //If no view is found
        if viewControllerToDisplay == nil {
            return
        }
        
        unselectAllButtons()  //No button should be in selected state
        

        let wasAlreadyShowingView: Bool = viewHandler.isShowing(viewToCheck: (viewControllerToDisplay!))
        
        
        //Hides buttons in linksHub view for animation
        hideButtons()
        
        
        if wasAlreadyShowingView { //when you want to close a view after done using it
            
            switch(sender.buttonLabel){ //To animate according to the button
            case "Camera":
                changeBackground(imageName: "")  //remove the background image
                CameraAnimator.isHidden = false  //show animation view
                CameraAnimator.addCameraAnimationReversed2Animation()//animate
              //  self.viewHandler.removeView(viewToRemove: viewControllerToDisplay!, animate: !isAnimating) //remove view that contains buttons
                self.viewHandler.removeView(viewToRemove: viewControllerToDisplay!, animate: false)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { //wait n secs ->n is number of secs that the animation lasts
                    self.CameraAnimator.isHidden = true //hide view for animation
                    self.disHideButtons() //show the buttons from the view containing main buttons -> Menu, Camera, Input, Volume
                }
                break
                
            case "Menu":
                changeBackground(imageName: "")  //remove the background image
                MenuAnimator.isHidden = false  //show animation view
                MenuAnimator.addMenuAnimationReversedAnimation()//animate
                self.viewHandler.removeView(viewToRemove: viewControllerToDisplay!, animate: false) //remove view that contains buttons
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) { //wait n secs ->n is number of secs that the animation lasts
                    self.MenuAnimator.isHidden = true //hide view for animation
                    self.disHideButtons() //show the buttons from the view containing main buttons -> Menu, Camera, Input, Volume
                }
                break
                
            case "Input":
                changeBackground(imageName: "")  //remove the background image
                InputAnimator.isHidden = false  //show animation view
                InputAnimator.addInputAnimationReversedAnimation()//animate
                self.viewHandler.removeView(viewToRemove: viewControllerToDisplay!, animate: false) //remove view that contains buttons
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { //wait n secs ->n is number of secs that the animation lasts
                    self.changeBackground(imageName: "")  //remove the background image
                    self.InputAnimator.isHidden = true //hide view for animation
                    self.disHideButtons() //show the buttons from the view containing main buttons -> Menu, Camera, Input, Volume
                }
                break
            case "Volume":
                changeBackground(imageName: "")  //remove the background image
                VolumeAnimator.isHidden = false  //show animation view
                VolumeAnimator.addVolumeAnimationReversedAnimation()//animate
                self.viewHandler.removeView(viewToRemove: viewControllerToDisplay!, animate: false) //remove view that contains buttons
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) { //wait n secs ->n is number of secs that the animation lasts
                    self.changeBackground(imageName: "")  //remove the background image
                    self.VolumeAnimator.isHidden = true //hide view for animation
                    self.disHideButtons() //show the buttons from the view containing main buttons -> Menu, Camera, Input, Volume
                }
                break
                
                
            default: break
            }
            

            
        }
        else{ // to open a view after clicking a button from bottom
            
            switch(sender.buttonLabel){ //To animate according to the button
            case "Camera":
                hideButtonsExcept(buttonExcluded: sender) //hide the buttons that are not the one that was clicked
                CameraAnimator.isHidden = false //show the view of the animation
                CameraAnimator.addCameraAnimation() //animate
                self.changeBackground(imageName: viewControllerToDisplay!.title! + "_afterAnimation.jpg") // puts the background image after animating
                break
            case "Menu":
                hideButtonsExcept(buttonExcluded: sender) //hide the buttons that are not the one that was clicked
                MenuAnimator.isHidden = false //show the view of the animation
                MenuAnimator.addMenuAnimation() //animate
                self.changeBackground(imageName: viewControllerToDisplay!.title! + "_afterAnimation.jpg") // puts the background image after animating
                break
            case "Input":
                hideButtonsExcept(buttonExcluded: sender) //hide the buttons that are not the one that was clicked
                InputAnimator.isHidden = false //show the view of the animation
                InputAnimator.addInputAnimation() //animate
                self.changeBackground(imageName: viewControllerToDisplay!.title! + "_afterAnimation.jpg") // puts the background image after animating
                break
            case "Volume":
                hideButtonsExcept(buttonExcluded: sender) //hide the buttons that are not the one that was clicked
                VolumeAnimator.isHidden = false //show the view of the animation
                VolumeAnimator.addVolumeAnimation() //animate
                self.changeBackground(imageName: viewControllerToDisplay!.title! + "_afterAnimation.jpg") // puts the background image after animating
                break
                
            default: break
            }
            
            sender.isSelected = true
            viewHandler.removeAllSubViews(fadeOutAnimate: false)
        
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {//wait for 1.4 secs for animation to happen
                
                self.viewHandler.addView(view: self.view, viewControllerToAdd: viewControllerToDisplay!, place: sender.view, fadeInAnim: false)
                
            self.CameraAnimator.isHidden = true // hide animation after it is done
            self.MenuAnimator.isHidden = true
            self.InputAnimator.isHidden = true
            self.VolumeAnimator.isHidden = true
            }
        }
            showButtons()
    }

    
    /**Changes background when button is pressed.  What the background changes to depends on which viewcontroller is being shown.
     Currently only works if single view can be displayed at a time*/
    @IBAction public func helpButtonTapped(_ sender: Button){
        for subview in view.subviews {//hide or show button labels for base view (the one that contains power button)
            if subview is Button {
                let button = subview as! Button
                if (button.titleLabel?.alpha == 1){
                button.titleLabel?.alpha = 0
                }
                else{
                    button.titleLabel?.alpha = 1
                }
            }
        }
        let viewDisplaying: UIViewController? = viewHandler.getView() //hide or show button labels for subview (ex. if camera is pressed;up,down,select,right...
        if (viewDisplaying != nil) {
            for subview in viewDisplaying!.view.subviews {
                if subview is Button {
                    let button = subview as! Button
                    if (button.titleLabel?.alpha==1){
                        button.titleLabel?.alpha = 0
                    }
                    else{
                        button.titleLabel?.alpha = 1
                    }
                }
            }
        }
    }
    
    /**Sets every button's isSelected field to false
     So no button shows up as selected*/
    private func unselectAllButtons(){
        
        for subview in view.subviews {
            if subview is Button {
                let button = subview as! Button
                button.isSelected = false
            }
        }
    }
    
    /**Finds and returns the view controller from the child view controllers that has the given title
     @param viewName is the view's name you are looking for*/
    private func findViewController(viewName: String) -> UIViewController? {
        
        //Goes through child view controllers until it finds one with same title/name
        for item in childViewControllers {
            
            if item.title != nil {
                if item.title! == viewName {
                    return item
                }
            }
        }
        return nil
    }
    
    /**Finds and returns the view from the child view controllers that has the given title
     @param viewName is the view's name you are looking for*/
    private func findView(viewName: String) -> UIView? {
        
        //Goes through child views until it finds one with same title/name
        for item in childViewControllers {
            if item.title != nil {
                if item.title! == viewName {
                    return item.view
                }
            }
        }
        return nil
    }
    
    /**Hides all buttons only in LinksHub view*/
    private func hideButtons(){
        for subview in view.subviews {
            if subview is Button {
                subview.alpha = 0
            }
        }
    }
    
    /**Hides all buttons only in LinksHub view*/
    private func showButtons(){
        for subview in view.subviews {
            if subview is Button {
                subview.alpha = 1
            }
        }
    }
    
    private func disHideButtons(){
        for subview in view.subviews {
            if subview is Button{
                subview.isHidden = false
            }
        }
    }
    
    private func hideButtonsExcept(buttonExcluded: Button){
        for subview in view.subviews {//hide or show button labels for base view (the one that contains power button)
            if subview is Button {
                let button = subview as! Button
                if (button.buttonLabel != buttonExcluded.buttonLabel &&
                    button.buttonLabel != "Home_btn" &&
                    button.buttonLabel != "Phone_btn" &&
                    button.buttonLabel != "Help_btn"
                    ){
                    button.isHidden = true
                }
            }
        }
    }
    
    /**Hides all subviews by removing their opacity/alpha,
     subviews include buttons*/
    private func hideAllSubviews(){
        for subviews in view.subviews {
            subviews.alpha = 0
        }
    }
    
    /**Shows all subviews by removing every subview's transparency*/
    public func showAllSubviews(){
        for subviews in view.subviews {
            subviews.alpha = 1
        }
    }
    
    /**Changes color of the status bar containing the clock and battery life*/
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /**Changes background to given background if no background is found from String, puts default background*/
    @discardableResult private func changeBackground(imageName: String) -> Bool{
        var image = UIImage(named: imageName)
        if(image == nil){
            image = defaultBackground!
        }
        backgroundView.image = image
        return true
    }
    
    /**Adds an imageView to view and sends it to the back*/
    private func initializeBackground(){
        backgroundView.contentMode = view.contentMode
        view.addSubview(backgroundView)
        view.sendSubview(toBack: backgroundView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeBackground()
        changeBackground(imageName: "") //Changes background to default
        
        //Removes all subviews from being shown at start
        viewHandler.removeAllChildViews(childViewControllers: childViewControllers)
        
    }
    
}
