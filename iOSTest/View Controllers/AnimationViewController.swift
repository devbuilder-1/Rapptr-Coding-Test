//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit
import Foundation
import AVFoundation

class AnimationViewController: UIViewController {
    
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     **/
    
    
    ///this is the image to be faded
    @IBOutlet weak var logoImage: UIImageView!
    
    
    ///set to faded false
    var isFaded = false
    
    
    ///guesture
    var dragGesture = UIPanGestureRecognizer()
    
    
    ///fade button
    @IBOutlet weak var fadeButton: UIButton!
    
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animation"
        

        
        ///make this image draggable
        self.addDragFunctionality()
        
        
    }
    
    
    func addDragFunctionality() {
        self.dragGesture = UIPanGestureRecognizer(target: self, action: #selector(AnimationViewController.draggedFunction(_:)))
        self.logoImage.isUserInteractionEnabled = true
        self.logoImage.addGestureRecognizer(dragGesture)
    }
    
    // MARK: - Actions
    @IBAction func backAction(_ sender: Any) {
        let mainMenuViewController = MenuViewController()
        self.navigationController?.pushViewController(mainMenuViewController, animated: true)
    }
    
    
    
    ///when they drag the image get all the guesture info
    @objc func draggedFunction(_ sender:UIPanGestureRecognizer){
        self.view.bringSubviewToFront(self.logoImage)
        let translation = sender.translation(in: self.view)
        self.logoImage.center = CGPoint(x: self.logoImage.center.x + translation.x, y: self.logoImage.center.y + translation.y)
        
        if self.logoImage.frame.origin.x + self.logoImage.frame.size.width >= self.view.bounds.width
            ||  self.logoImage.frame.origin.x <= self.view.bounds.origin.x {
         
            self.addVibrationsAndScreenSplash()
        }
        
        
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    
    
    ///this function adds vibrations and splashes teh screen
    func addVibrationsAndScreenSplash()  {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        
       self.view.backgroundColor =  UIColor.red
        
        UIView.animate(withDuration: 0.4, animations: {
            
            self.view.backgroundColor =  UIColor(red: 12, green: 34, blue: 56, alpha: 1)
          }) { _ in
            
            self.view.backgroundColor =  UIColor.red
            self.view.backgroundColor =  UIColor(red: 12, green: 34, blue: 56, alpha: 1)
          }
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        
        if isFaded {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
                self.logoImage.alpha = 1
                
            }, completion: {_ in
                self.isFaded = false
               // self.fadeButton.titleLabel!.text! = "FADE IN"
                
            })
        }
        
        
        if !isFaded {
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
                self.logoImage.alpha = 0
            }, completion: { _ in
                self.isFaded = true
              //  self.fadeButton.titleLabel!.text! = "FADE OUT"
            })
        }
        
        
    }
    
    
}
