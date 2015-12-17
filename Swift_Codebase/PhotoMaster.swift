//
//  PhotoMaster.swift
//  Rings
//
//  Created by SEAN HD on 2015/9/5.
//  Copyright (c) 2015年 PROJECTS. All rights reserved.
//  Mod timestamp: 2015-12-17
//

import UIKit

class PhotoMaster: NSObject, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let master = PhotoMaster()
    
    // Object
    private var thisViewController: UIViewController?
    private var imagePicker: UIImagePickerController?
    private var actionSheet: UIActionSheet?
    
    // * Used in somewhere
    var imagePickedDoneAction: (image:UIImage, picker:UIImagePickerController) -> Void = { image -> Void in
        
    }
    
    // * Used in ViewDidLoad
    internal func registerToMyViewController(target: UIViewController) {
        thisViewController = target
    }
    
    // * Used in button action
    internal func askProfoundQuestions() {
        if imagePicker == nil {
            imagePicker = UIImagePickerController()
            imagePicker!.delegate = self
        }
        
        if actionSheet == nil {
            actionSheet = UIActionSheet(title: "Choose a photo", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Take a photo", "Choose from camera roll")
        }
        
        actionSheet?.showInView(self.thisViewController!.view)
    }
    
    // MARK: ActionSheet Delegate
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        switch (buttonIndex) {
        case 1:
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                
                imagePicker?.sourceType = UIImagePickerControllerSourceType.Camera
                imagePicker!.allowsEditing = true
                self.thisViewController!.presentViewController(imagePicker!, animated: true, completion: { () -> Void in
                    
                })
                
            }
        case 2:
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum) {
                imagePicker!.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
                imagePicker!.allowsEditing = true
                self.thisViewController!.presentViewController(imagePicker!, animated: true, completion: { () -> Void in
                    
                })
            }
        default:
            print("Action sheet cancel")
        }
    }
    
    // MARK: Image Picker Delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        
        imagePickedDoneAction(image: image, picker: picker)
    }
    
    
    
    
}
