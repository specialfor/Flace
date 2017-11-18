//
//  AlertManager.swift
//  Nynja
//
//  Created by Anton Makarov on 24.05.17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import Foundation
import UIKit

typealias Handler = (()->Void)

class AlertManager {

    static let sharedInstance : AlertManager = {
        let instance = AlertManager()
        return instance
    }()

    func showAlertOk(title: String, message: String, completion:(()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            completion?()
        }
        alert.addAction(defaultAction)
        let vc = UIApplication.shared.keyWindow?.rootViewController
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func showAlertOk(message: String, completion:(()->Void)? = nil) {
        showAlertOk(title: "", message: message, completion: completion)
    }
    
    func showAlertOkCancel(message: String, completionOk:(()->Void)? = nil, completionCancel:(()->Void)? = nil) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            completionOk?()
        }
        let secondAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            completionCancel?()
        }
        alert.addAction(defaultAction)
        alert.addAction(secondAction)
        let vc = UIApplication.shared.keyWindow?.rootViewController
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTwoActions(title: String, message: String, firstActionTitle: String,
                                 secondActionTitle: String, firstAction: Handler?,
                                 secondAction: Handler?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let firstAlertAction = UIAlertAction(title: firstActionTitle, style: .default) { (action) in
            firstAction?()
        }
        let secondAlertAction = UIAlertAction(title: secondActionTitle, style: .default) { (action) in
            secondAction?()
        }
        alert.addAction(firstAlertAction)
        alert.addAction(secondAlertAction)
        let vc = UIApplication.shared.keyWindow?.rootViewController
        vc?.present(alert, animated: true, completion: nil)
    }
    
    func showAlertAllowPermission(title: String = "", resourceName: String) {
        let message = String(format: "Please allow pesmission for", resourceName)
        
        AlertManager.sharedInstance.showAlertWithTwoActions(title: title, message: message, firstActionTitle: "Deny", secondActionTitle: "Please, go to settings and turn on feature", firstAction: nil, secondAction: {
            
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        })
    }

    func showActionSheet(title: String?, message: String?, actions: [UIAlertAction]) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { actionSheet.addAction($0) }
        
        let vc = UIApplication.shared.keyWindow?.rootViewController
        vc?.present(actionSheet, animated: true, completion: nil)
    }
    
    func showNativeShare(with activityItems: [Any]) {
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        let vc = UIApplication.shared.keyWindow?.rootViewController
        vc?.present(activityViewController, animated: true, completion: nil)
    }
    
}
