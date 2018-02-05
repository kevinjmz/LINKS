//
//  LinksStart.swift
//  Linked
//
//  Created by Gerardo Cervantes and Kevin Jimenez on 2/9/17 1/28/2018.
//  Copyright © 2017 Gerardo Cervantes and Kevin Jimenez. All rights reserved.
//


import UIKit

class LinksStart: UIViewController {
    
    
    /**Button handler used to handle all buttons, provides more functionality to all the buttons*/
    @IBOutlet var buttonHandler: ButtonHandler!
    
    /**Used to show animations*/
    private let animation: Animation = Animation()
    
    /**Segues to the hub view controller when clicked.  
     If it finds animation, then it will do it before segueing*/
    @IBAction public func startButtonTapped(_ sender: Button){
        segueToHub()
    }
    
    /*Must be public and must be called update unless using IOS10+ then you can modify timer code, used to segue after the animation is complete*/
    public func segueToHub(){
        performSegue(withIdentifier: "toHub", sender: nil)
    }
    
    /*Hides all button subviews by setting their opacity to 0*/
    private func hideButtons(){
        for subview in view.subviews {
            if subview is Button {
                subview.alpha = 0
            }
        }
    }
    
    /**Shows all the button subviews by setting their opacity to 1*/
    public func showButtons(){
        for subview in view.subviews {
            if subview is Button {
                subview.alpha = 1
            }
        }
    }
    
    /**Starting animation that occurs when the app is starting up
     The animation introduces the button into view*/
    private func startingAnimation(){
        let animationDuration: Double = 1.35

        if animation.animate(viewToPlaceOn: view, imageName: "Start_Animation", imageExtension: "png", x: -11, y: Int(view.frame.size.height.subtracting(207)), width: 226, height: 220, duration: animationDuration, reverse: false) {
    
            Timer.scheduledTimer(timeInterval: animationDuration, target: self, selector: #selector(self.showButtons), userInfo: nil, repeats: false)
        }
        else{
            showButtons()
        }
    }
    
    /**Adds background to view, creates imageView from image name given, scales it*/
    private func addBackground(imageName: String){
        
        let image = UIImage(named: imageName)
        if(image == nil){
            return
        }
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = image
        backgroundImageView.contentMode = view.contentMode
        
        view.addSubview(backgroundImageView)
        view.sendSubview(toBack: backgroundImageView)
        
    }
 
    /**Changes color of the status bar to white, status bar displays time and battery life*/
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideButtons()
        
        startingAnimation()
        addBackground(imageName: "GridBackground.jpg")
    }
}
