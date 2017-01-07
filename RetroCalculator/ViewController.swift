//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Drago on 1/6/17.
//  Copyright © 2017 Novotek. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    @IBOutlet weak var outputLbl: UILabel!
    var runningNumber = ""
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var leftValString = "0"
    var rightValString = "0"
    var result = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        outputLbl.text = ""

        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        outputLbl.text = ""
        leftValString = ""
        rightValString = ""
        runningNumber = ""
        currentOperation = Operation.Empty
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValString = runningNumber
                runningNumber = ""
            
            
            if currentOperation == Operation.Divide {
                result = "\(Double(leftValString)! / Double(rightValString)!)"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValString)! + Double(rightValString)!)"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValString)! - Double(rightValString)!)"
            } else if currentOperation == Operation.Multiply {
                result = "\(Double(leftValString)! * Double(rightValString)!)"
            }
            leftValString = result
            outputLbl.text = result
            }
            currentOperation = operation
        }else {
            //this is the first time operator has been pressed
            leftValString = runningNumber
            runningNumber = ""
            currentOperation = operation
            
        }
        
    }

   

}

