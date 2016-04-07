//
//  ViewController.swift
//  retro_calculator
//
//  Created by Lucas Franco on 3/14/16.
//  Copyright © 2016 Lucas Franco. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    enum Operations: String{
        case Divide = "/"
        case Multiply = "*"
        case Add = "+"
        case Subtract = "-"
        case Empty = "Empty"
    }
    
    func playsound() {
        
        if btnSound.playing {
            btnSound.stop()
        }
        btnSound.play()
    }
   
    
    @IBOutlet weak var resultlbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    var runningnumber = ""
    var leftvalString = ""
    var rightvalString = ""
    var currentOperation : Operations = Operations.Empty
    var result = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: path!)
        
        do{
           try btnSound = AVAudioPlayer(contentsOfURL: soundURL)
        } catch let err as NSError{
            print(err.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnpressed (btn: UIButton){
        playsound()
        
        runningnumber += "\(btn.tag)"
        resultlbl.text = runningnumber 
    }
    
    @IBAction func OnDividePressed(sender: AnyObject) {
        processoperation(Operations.Divide)
    }
    
    @IBAction func OnMultiplyPressed(sender: AnyObject) {
        processoperation(Operations.Multiply)
    }
    
    @IBAction func OnSubtractPressed(sender: AnyObject) {
        processoperation(Operations.Subtract)
    }
    
    @IBAction func OnAddPressed(sender: AnyObject) {
        processoperation(Operations.Add)
    }
    
    @IBAction func OnEqualPressed(sender: AnyObject) {
        processoperation(currentOperation)
    }
    
   

    func processoperation (op: Operations){
        playsound()
        
        if currentOperation != Operations.Empty {
            
            
            if runningnumber != "" {
                rightvalString = runningnumber
                runningnumber = ""
                
                if currentOperation == Operations.Divide{
                    result = "\(Double(leftvalString)! / Double (rightvalString)!)"
            } else if currentOperation == Operations.Multiply {
                    result = "\(Double(leftvalString)! * Double (rightvalString)!)"
                } else if  currentOperation == Operations.Subtract{
                    result = "\(Double(leftvalString)! - Double(rightvalString)!)"
                    } else if  currentOperation == Operations.Add{
                    result = "\(Double(leftvalString)! + Double(rightvalString)!)"
                }
                leftvalString = result
                resultlbl.text = result
            }
           
                
            currentOperation  = op
            
    }   else {
            leftvalString = runningnumber
            runningnumber = ""
            currentOperation = op
        }
        
    }
    }

