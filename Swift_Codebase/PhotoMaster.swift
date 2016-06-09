//
//  PhotoMaster.swift
//  Rings
//
//  Created by SEAN HD on 2015/9/5.
//  Copyright (c) 2015年 PROJECTS. All rights reserved.
//  Mod timestamp: 2015-12-17
//

import UIKit


/**
Usage example:

```swift
PhotoMaster.master.registerToMyViewController(self)
PhotoMaster.master.imagePickedDoneAction = { image, imageBase64, picker in
let img:UIImage = image
self.imageSelectedInBase64 = PhotoMaster.master.getBase64StringFromImage(img.resizeToWidth(100))
picker.dismissViewControllerAnimated(true, completion: nil)
self.profileImageView.image = image
}
PhotoMaster.master.askProfoundQuestions()
```

*/

class PhotoMaster: NSObject, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    static let sharedInstance = PhotoMaster()
    
    // Object
    private var thisViewController: UIViewController?
    private var imagePicker: UIImagePickerController?
    private var actionSheet: UIActionSheet?
    
    // * Used in somewhere
    var imagePickedDoneAction: (image:UIImage, imageInBase64: String, picker:UIImagePickerController) -> Void = { image -> Void in
        
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
            actionSheet = UIActionSheet(title: "Choose A Photo", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Take A Photo", "Choose From Camera Roll")
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
        
        imagePickedDoneAction(
            image: image,
            imageInBase64:self.getBase64StringFromImage(image),
            picker: picker)
    }
    
    func getBase64StringFromImage(image: UIImage) -> String {
        let base64String: String = (UIImageJPEGRepresentation(image, 1)?.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength))!
        return base64String
    }
    
    
}

extension UIImage {
    
    func resize(scale:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width*scale, height: size.height*scale)))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    func resizeToWidth(width:CGFloat)-> UIImage {
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.image = self
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
