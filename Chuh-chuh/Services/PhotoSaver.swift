//
//  PhotoSaver.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/18/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit

class PhotoSaver {
    
    func saveImage(_ image: UIImage) -> String? {
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        
        let imgPath = URL(fileURLWithPath: documentDirectoryPath.appendingPathComponent("\(Date().timeIntervalSince1970).jpg"))
        
        if !FileManager.default.fileExists(atPath: imgPath.path) {
            do {
                try UIImageJPEGRepresentation(image, 1.0)?.write(to: imgPath, options: .atomic)
                
                return imgPath.absoluteString
            } catch let error {
                print(error.localizedDescription)
                return nil
            }
        } else {
            return imgPath.absoluteString
        }
        
    }
    
}
