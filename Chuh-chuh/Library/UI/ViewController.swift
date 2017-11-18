//
//  ViewController.swift
//  Boozemeter
//
//  Created by Volodymyr Hryhoriev on 11/5/17.
//  Copyright © 2017 NoblesTeam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = theme.backgroundColor
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,selector: #selector(self.keyboardNotification),name: NSNotification.Name.UIKeyboardWillChangeFrame,object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func initialize() {}
    
    // MARK: Keyboard
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo as? [String:Any] {
            if let endFrame = (userInfo["UIKeyboardFrameEndUserInfoKey"] as? NSValue)?.cgRectValue {
                let duration: TimeInterval = (userInfo["UIKeyboardAnimationDurationUserInfoKey"] as? NSNumber)?.doubleValue ?? 0
                let animationCurveRawNSN = userInfo["UIKeyboardAnimationCurveUserInfoKey"] as? NSNumber
                let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseOut.rawValue
                let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
                self.keyboardNotified(endFrame: endFrame)
                
                UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
                    self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    func keyboardNotified(endFrame: CGRect) {}
    
    func isKeyboardGoingToHide(_ endFrame: CGRect) -> Bool {
        return endFrame.origin.y >= UIScreen.main.bounds.size.height
    }
    
}
