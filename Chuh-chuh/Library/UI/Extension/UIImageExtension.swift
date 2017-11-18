//
//  UIImageExtension.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit

extension UIImage {
    
    convenience init?(fileUrl: URL) {
        guard let imageData = try? Data(contentsOf: fileUrl) else {
            return nil
        }
        
        self.init(data: imageData)
    }
    
}
