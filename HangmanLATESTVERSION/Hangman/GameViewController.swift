//
//  GameViewController.swift
//  Hangman
//
//  Created by Nicolas Zoghb on 3/17/16.
//  Copyright © 2016 Nicolas Zoghb. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        hardmodeSwitch.addTarget(self, action: Selector("hardmodeOn:"), forControlEvents: UIControlEvents.ValueChanged)
        
        // Do any additional setup after loading the view.
    }

    func hardmodeOn(mySwitch: UISwitch) {
        if mySwitch.on {
            hardmodeImage.image = UIImage(named: "hm.png")
            onOff = true
        } else {
            hardmodeImage.image = nil
            onOff = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var hardmodeSwitch: UISwitch!
    @IBOutlet weak var hardmodeImage: UIImageView!
    
    var onOff = false

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toHangman") {
            let destination = segue.destinationViewController as! UINavigationController
            
            let hangmanVC = destination.viewControllers.first as! HangmanViewController
            
            hangmanVC.onOff = onOff
            
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
