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
        let defaultManager = FileManager.default
        
        guard let directoryUrl = try? defaultManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            return nil
        }
        
        let fileUrl = directoryUrl.appendingPathComponent("\(Date().timeIntervalSince1970).jpg")

        if !defaultManager.fileExists(atPath: fileUrl.path) {
            if let _ = UIImageJPEGRepresentation(image, 1.0) {
                return fileUrl.path
            } else {
                return nil
            }
        } else {
            return fileUrl.path
        }
    }
    
}
