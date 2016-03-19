//
//  HangmanViewController.swift
//  Hangman
//
//  Created by Nicolas Zoghb on 3/17/16.
//  Copyright © 2016 Nicolas Zoghb. All rights reserved.
//

import UIKit
import Foundation

class HangmanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //phrase mechanism
        // Initialize HangmanPhrase with an array of all possible phrases of the Hangman game
        let path = NSBundle.mainBundle().pathForResource("phrases", ofType: "plist")
        phrases = NSArray.init(contentsOfFile: path!)
        
        self.answerPhrase = getRandomPhrase(phrases)
        
        var io : Bool = true
        for i in 0...(self.answerPhrase.characters.count - 1) {
            if Array(self.answerPhrase.characters)[i] == " " {
                if io {
                    self.listOfCorrectLetters.append(" ")
                    io = false
                } else {
                    self.listOfCorrectLetters.append("\n")
                    io = true
                }
            } else {
                self.listOfCorrectLetters.append("_")
            }
        }
        
        hangmanImage.image = UIImage(named: "basic-hangman-img/hangman1.gif")
        if onOff {
            hangmanImage.image = UIImage(named: "basic-hangman-img/hangman6.gif")
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.75, target: self, selector: "timerAction", userInfo: nil, repeats: true)
        } else {
            hm2Mins.text = nil
            hmTimer.text = nil
        }
        phraseAnswer.text = "  " + listOfCorrectLetters.joinWithSeparator(" ") + "  "
        
        print(answerPhrase)
        //button assignments
        aButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        bButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        cButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        dButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        eButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        fButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        gButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        hButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        iButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        jButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        kButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        lButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        mButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        nButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        oButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        pButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        qButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        rButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        sButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        tButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        uButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        vButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        wButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        xButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        yButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        zButton.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)
        
        startOverButton.target = self
        startOverButton.action = "startOver"
        
        quitButton.target = self
        quitButton.action = "quit"
        
        // Do any additional setup after loading the view.
    }
    
    var timer = NSTimer()
    var counter = 120
    
    func timerAction() {
        if counter > 0 {
            --counter
            hmTimer.text = "\(counter)"
        }
        if counter <= 0 {
            showAlertButtonTappedLose()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //phrase mechanism
    // Get random phrase from all available phrases
    func getRandomPhrase(list: NSArray) -> String! {
        let index = Int(arc4random_uniform(UInt32(phrases.count)))
        return list.objectAtIndex(index) as! String
    }
    
    //exit
    @IBAction func unwindToGameViewController(segue:UIStoryboardSegue) {
    }
    
    //alerts
    //win
    @IBAction func showAlertButtonTappedWin() {
        // create the alert (win)
        let alert = UIAlertController(title: "You Win!", message: "Victory is yours, sick!", preferredStyle: UIAlertControllerStyle.Alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK :)", style: UIAlertActionStyle.Default, handler: { action in
            self.quit()
        }))
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    //lose
    @IBAction func showAlertButtonTappedLose() {
        // create the alert (win)
        let alert = UIAlertController(title: "You Lose", message: "Reflect on your life's failures...", preferredStyle: UIAlertControllerStyle.Alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK :(", style: UIAlertActionStyle.Default, handler: { action in
            self.quit()
        }))
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func checkWins() {
        var tempList = listOfCorrectLetters
        for i in 0...(tempList.count - 1) {
            if tempList[i] == "\n" {
                tempList[i] = " "
            }
        }
        var thresholdToLose = 6
        if onOff {
            thresholdToLose = 1
        }
        if tempList.joinWithSeparator("") == answerPhrase {
            self.showAlertButtonTappedWin()
        } else if listOfWrongLetters.count >= thresholdToLose {
            self.showAlertButtonTappedLose()
        }
    }
    
    var onOff : Bool = false
    var phrases : NSArray!
    var answerPhrase : String = ""
    var listOfCorrectLetters: [String] = []
    var listOfWrongLetters: [String] = []
    
    @IBOutlet weak var hangmanImage: UIImageView!
    @IBOutlet weak var phraseAnswer: UILabel!
    @IBOutlet weak var startOverButton: UIBarButtonItem!
    @IBOutlet weak var wrongAnswers: UILabel!
    @IBOutlet weak var quitButton: UIBarButtonItem!
    @IBOutlet weak var hm2Mins: UILabel!
    @IBOutlet weak var hmTimer: UILabel!
    
    func changeImage() {
        switch listOfWrongLetters.count {
        case 0:
            hangmanImage.image = UIImage(named: "basic-hangman-img/hangman1.gif")
        case 1:
            hangmanImage.image = UIImage(named: "basic-hangman-img/hangman2.gif")
        case 2:
            hangmanImage.image = UIImage(named: "basic-hangman-img/hangman3.gif")
        case 3:
            hangmanImage.image = UIImage(named: "basic-hangman-img/hangman4.gif")
        case 4:
            hangmanImage.image = UIImage(named: "basic-hangman-img/hangman5.gif")
        case 5:
            hangmanImage.image = UIImage(named: "basic-hangman-img/hangman6.gif")
        case 6:
            hangmanImage.image = UIImage(named: "basic-hangman-img/hangman7.gif")
        default:
            hangmanImage.image = UIImage(named: "basic-hangman-img/hangman1.gif")
        }
    }
    
    func startOver() {
        self.listOfCorrectLetters = []
        self.listOfWrongLetters = []
        self.answerPhrase = getRandomPhrase(phrases)
        var io : Bool = true
        for i in 0...(self.answerPhrase.characters.count - 1) {
            if Array(self.answerPhrase.characters)[i] == " " {
                if io {
                    self.listOfCorrectLetters.append(" ")
                    io = false
                } else {
                    self.listOfCorrectLetters.append("\n")
                    io = true
                }
            } else {
                self.listOfCorrectLetters.append("_")
            }
        }
        phraseAnswer.text = "  " + self.listOfCorrectLetters.joinWithSeparator(" ") + "  "
        wrongAnswers.text = self.listOfWrongLetters.joinWithSeparator(" ")
        for i in listOfDisabledButtons {
            i.enabled = true
        }
        print(self.answerPhrase)
    }
    
    func quit() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //ahhhhhhhhhhh
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var eButton: UIButton!
    @IBOutlet weak var fButton: UIButton!
    @IBOutlet weak var gButton: UIButton!
    @IBOutlet weak var hButton: UIButton!
    @IBOutlet weak var iButton: UIButton!
    @IBOutlet weak var jButton: UIButton!
    @IBOutlet weak var kButton: UIButton!
    @IBOutlet weak var lButton: UIButton!
    @IBOutlet weak var mButton: UIButton!
    @IBOutlet weak var nButton: UIButton!
    @IBOutlet weak var oButton: UIButton!
    @IBOutlet weak var pButton: UIButton!
    @IBOutlet weak var qButton: UIButton!
    @IBOutlet weak var rButton: UIButton!
    @IBOutlet weak var sButton: UIButton!
    @IBOutlet weak var tButton: UIButton!
    @IBOutlet weak var uButton: UIButton!
    @IBOutlet weak var vButton: UIButton!
    @IBOutlet weak var wButton: UIButton!
    @IBOutlet weak var xButton: UIButton!
    @IBOutlet weak var yButton: UIButton!
    @IBOutlet weak var zButton: UIButton!
    
    
    //kill me please
    func buttonPressed(sender: UIButton) {
        var letter: String = " "
        switch sender {
        case aButton:
            letter = "a"
        case bButton:
            letter = "b"
        case cButton:
            letter = "c"
        case dButton:
            letter = "d"
        case eButton:
            letter = "e"
        case fButton:
            letter = "f"
        case gButton:
            letter = "g"
        case hButton:
            letter = "h"
        case iButton:
            letter = "i"
        case jButton:
            letter = "j"
        case kButton:
            letter = "k"
        case lButton:
            letter = "l"
        case mButton:
            letter = "m"
        case nButton:
            letter = "n"
        case oButton:
            letter = "o"
        case pButton:
            letter = "p"
        case qButton:
            letter = "q"
        case rButton:
            letter = "r"
        case sButton:
            letter = "s"
        case tButton:
            letter = "t"
        case uButton:
            letter = "u"
        case vButton:
            letter = "v"
        case wButton:
            letter = "w"
        case xButton:
            letter = "x"
        case yButton:
            letter = "y"
        case zButton:
            letter = "z"
        default: break
        }
        if self.answerPhrase.lowercaseString.containsString(letter) {
            for i in 0...(self.answerPhrase.characters.count - 1) {
                if Array(self.answerPhrase.lowercaseString.characters)[i] == Array(letter.characters)[0] {
                    self.listOfCorrectLetters[i] = letter.uppercaseString
                }
            }
        } else {
            self.listOfWrongLetters.append(letter)
        }
        //print(Array(letter.characters))
        //print(listOfCorrectLetters)
        //print(listOfWrongLetters)
        sender.enabled = false
        listOfDisabledButtons.append(sender)
        phraseAnswer.text = "  " + self.listOfCorrectLetters.joinWithSeparator(" ") + "  "
        wrongAnswers.text = self.listOfWrongLetters.joinWithSeparator(" ")
        if !onOff {
            changeImage()
        } else {
            hangmanImage.image = UIImage(named: "basic-hangman-img/hangman7.gif")
        }
        checkWins()
    }

    var listOfDisabledButtons: [UIButton] = []
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
