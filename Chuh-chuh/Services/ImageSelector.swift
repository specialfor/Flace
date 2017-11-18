//
//  ImageSelector.swift
//  Nynja
//
//  Created by Anton Makarov on 31.10.17.
//  Copyright © 2017 TecSynt Solutions. All rights reserved.
//

import UIKit
import MobileCoreServices

protocol ImageSelectorDelegate: class {
    func selected(image: UIImage)
    func imageSelectorCanceled()
}

class ImageSelector: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let sharedInstance : ImageSelector = {
        let instance = ImageSelector()
        return instance
    }()
    
    weak var delegate:ImageSelectorDelegate?
    var navigation: UINavigationController?
    
    func showPhotoActionSheet(navigation: UINavigationController) {
        self.navigation = navigation
        let actionSheet = UIAlertController(title: nil,
                                            message: "Choose Action",
                                            preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take from camera",
                                            style: .default,
                                            handler: { (action) in
                                                self.loadFromCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Select from gallery",
                                            style: UIAlertActionStyle.default,
                                            handler: { (action) in
                                                self.showImagePicker()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            self.delegate?.imageSelectorCanceled()
        }))
        navigation.present(actionSheet, animated: true, completion: nil)
    }
    
    private func showImagePicker() {
        PermissionManager().requestGaleryPermission { (status) in
            if status == .authorized {
                self.presentImagePicker(with: .photoLibrary)
            }
        }
    }
    
    private func loadFromCamera(isPhoto: Bool = true ) {
        PermissionManager().requestCameraPermission { (status) in
            if status == .authorized {
                self.presentImagePicker(with: .camera)
            }
        }
    }
    
    private func presentImagePicker(with sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.mediaTypes = [kUTTypeImage as String]
        navigation?.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let pickedImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            navigation?.dismiss(animated: true, completion: nil)
            return
        }
        delegate?.selected(image: pickedImage)
        navigation?.dismiss(animated: false, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.imageSelectorCanceled()
        navigation?.dismiss(animated: false, completion: nil)
    }
}
