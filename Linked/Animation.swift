//
//  Animation.swift
//  Linked
//
//  Created by Gerardo Cervantes and Kevin Jimenez on 3/10/17.
//  Copyright © 2017 Gerardo Cervantes and Kevin Jimenez. All rights reserved.
//

import UIKit
import Foundation

public class Animation {
    
    /**The image that will animate*/
    private var animatingImage: UIImageView? = nil
    
    
    /**Animates the image onto the view, animation is done by using various images.
     @param viewToPlaceOn is where you want to place animating image
     @param imageName is name of image that's in the assets folder that you want to animate
     @param imageExtension is file extension of the image.  Example: png, jpg
     @param x and y are used for image placement, (0,0) is top-left
     @return true if was able to animate, return false if couldn't*/
    public func animate(viewToPlaceOn: UIView, imageName: String, imageExtension: String, x: Int, y: Int, width: Int, height:Int, duration: Double, reverse: Bool) -> Bool{
        
        
        animatingImage = createAnimationImageView(imageName: imageName, extensionName: imageExtension, reverse: reverse)
        
        
        if animatingImage == nil{
            return false
        }
        
        showImageView(viewToPlaceOn: viewToPlaceOn, imageView: animatingImage!, x: x, y: y, width: width, height: height)
        
        animateImageView(animationView: animatingImage!, duration: duration, repeatCount: 1)
        
        //Sets a timer to finish after the animation finishes, after animation it will run the segueToHub() method once
        Timer.scheduledTimer(timeInterval: duration, target: self, selector: #selector(self.removeImage), userInfo: nil, repeats: false)
        
        return true
    }
    
    
    /**Removes the animating images from it's superview*/
    @objc public func removeImage(){
        if animatingImage != nil {
            animatingImage!.removeFromSuperview()
        }
    }
    
    /**If you want to do an animation of 3 frames with images: anim1.png, anim2.png, anim3.png
     Then imageName should be: "anim"
     Extension should be: "png"  */
    private func createAnimationImageView(imageName: String, extensionName: String, reverse: Bool) -> UIImageView?{
        
        var images: [UIImage] = [UIImage]()
        var fullImageName: String = ""
        var imageFound: UIImage? = nil
        var imgNumber = 1
        
        if reverse {
            imgNumber = findStartingReverseImage(imageName: imageName, extensionName: extensionName)
        }
        
        imageFound = UIImage(named: imageName + String(imgNumber) + "." + extensionName)
        
        if imageFound == nil {
            return nil
        }
        
        //Keeps animating until it can't find the next image
        while imageFound != nil {
            
            fullImageName = imageName + String(imgNumber) + "." + extensionName
            imageFound = UIImage(named: fullImageName)
            
            if(imageFound != nil){
                images.append(imageFound!)
            }
            
            imgNumber = reverse ? imgNumber-1 : imgNumber+1 //Increments by 1 if reverse false, otherwise decrements
        }
        
        if images.count == 0 {
            return nil
        }
        
        let animationView: UIImageView = UIImageView(image: images.last)
        
        animationView.animationImages = images
        return animationView
    }
    
    /**Uses binary search to find the last image of animation*/
    private func findStartingReverseImage(imageName: String, extensionName: String) -> Int{
        
        var low = 0
        var high = 1000
        var imageFound: UIImage? = nil

        //Iterations used as a safety net
        var iterations = 0
        while low < high && iterations < 1000 {
            let  fullImageName = imageName + String((low+high)/2) + "." + extensionName
            imageFound = UIImage(named: fullImageName)
            if imageFound == nil {
                high = (low+high-1)/2
            }
            else{
                low = (low+high+1)/2
            }
            iterations += 1
        }
        
        return low-1
    }
    
    /**Starts to animate the imageView
     @param duration of animation
     @param repeatCount how much times it should repeat the animation*/
    private func animateImageView(animationView: UIImageView, duration: Double, repeatCount: Int){
        
        animationView.animationDuration = duration
        animationView.animationRepeatCount = repeatCount
        animationView.startAnimating()
    }
    
    /**Shows the UIImageView
     @param imageView the image you want to show
     @param x and y are the coordinates where you want to show the image, (0,0) is the top-left corner of the image
     @param width and height of image*/
    private func showImageView(viewToPlaceOn :UIView, imageView: UIImageView,x: Int, y: Int, width: Int, height: Int){
        
        imageView.frame = CGRect(x: x, y: y, width: width, height: height)
        viewToPlaceOn.addSubview(imageView)
        viewToPlaceOn.bringSubview(toFront: imageView)
    }
}
 
