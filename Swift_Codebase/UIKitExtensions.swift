//
//  UIKitExtensions.swift
//  Swift_Codebase
//
//  Created by Sean Chen on 2016/1/6.
//  Copyright © 2016年 Rings. All rights reserved.
//

import Foundation
import UIKit
import ActionKit
import Alamofire
import AlamofireImage

extension SequenceType where Generator.Element: Comparable {
    func distinct() -> [Generator.Element] {
        var rtn: [Generator.Element] = []
        
        for x in self {
            if !rtn.contains(x) {
                rtn.append(x)
            }
        }
        return rtn
    }
}

// MARK: - UIView
extension UIView {
    func x() -> CGFloat {
        return self.frame.origin.x
    }
    
    func y() -> CGFloat {
        return self.frame.origin.y
    }
    
    func width() -> CGFloat {
        return self.frame.size.width
    }
    
    func height() -> CGFloat {
        return self.frame.size.height
    }
}

extension UIView {
    func becomeMask() {
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.4)
    }
    
    func becomeMaskWithAlpha(maskAlpha: CGFloat) {
        self.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(maskAlpha)
    }
    
    func makeRounded(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
    
    func makeCircle() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.masksToBounds = true
    }
}

extension UIView {
    func getHorizontalEnd() -> CGFloat {
        return self.frame.origin.x + self.frame.size.width
    }
    
    func getVerticalEnd() -> CGFloat {
        return self.frame.origin.y + self.frame.size.height
    }
    
    enum RectProp {
        case X
        case Y
        case Width
        case Height
    }
    
    func setPropValue(prop: RectProp, toValue: CGFloat) {
        
        var temp = self.frame
        
        switch prop {
        case .X:
            temp.origin.x = toValue
        case .Y:
            temp.origin.y = toValue
        case .Width:
            temp.size.width = toValue
        case .Height:
            temp.size.height = toValue
        }
        
        self.frame = temp
        
    }
    
    func getPropValue(prop: RectProp) -> CGFloat {
        switch prop {
        case .X:
            return self.frame.origin.x
        case .Y:
            return self.frame.origin.y
        case .Width:
            return self.frame.size.width
        case .Height:
            return self.frame.size.height
        }
    }
}

extension UIView {
    func getSizeThatFits() -> CGSize {
        let temp = self.sizeThatFits(CGSizeMake(CGFloat.max, CGFloat.max))
        return temp
    }
    
    func changeSizeWithOriginalCenter(newSize: CGSize) {
        var temp = self.frame
        let originalCenter = self.center
        temp.size = newSize
        self.frame = temp
        self.center = originalCenter
    }
    
    func changeWidthWithOriginalTrailing(newWidth: CGFloat) {
        var temp = self.frame
        let originalWidth = temp.size.width
        temp.origin.x = temp.origin.x + originalWidth - newWidth
        temp.size.width = newWidth
        self.frame = temp
    }
}

extension UIControl {
    public func addTapHandler(handler: () -> ()) {
        self.addControlEvent(UIControlEvents.TouchUpInside, closure: handler)
    }
}

//MARK: - UILabel
extension UILabel {
    
    func animateSelf(toColor: UIColor) {
        let origin = self.textColor
        UIView.transitionWithView(self, duration: 0.15, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.textColor = toColor
            }) { (done) -> Void in
                self.textColor = origin
        }
    }
    
}

// MARK: - UIButton
extension UIButton {
    
    func animateItself() {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.backgroundColor = self.backgroundColor?.darker()
            }) { (done) -> Void in
                UIView.animateWithDuration(0.2, animations: { () -> Void in
                    self.backgroundColor = self.backgroundColor?.lighter()
                })
        }
    }
    
}

extension UIButton {
    func makeRoundButton() {
        self.layer.cornerRadius = self.frame.size.height / 2
    }
    
    func makeDismissButton(target: UIViewController, dismissAnimately: Bool) {
        self.addControlEvent(.TouchUpInside) { () -> () in
            target.dismissViewControllerAnimated(dismissAnimately, completion: { () -> Void in
                
            })
        }
    }
}

extension UIButton {
    func makeConfirmGreen() {
        self.setTitleColor(UIColor.buttonColor().confirmGreen, forState: UIControlState.Normal)
        self.setTitleColor(UIColor.buttonColor().confirmGreen.darker(), forState: UIControlState.Highlighted)
    }
}

extension UIBarButtonItem {
    
}

// MARK: - UIColor
extension UIColor { // darker
    
    func darker() -> UIColor {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return UIColor(hue: h, saturation: s, brightness: b * 0.8, alpha: a)
        }
        
        return UIColor.whiteColor()
    }
    
    func lighter() -> UIColor {
        var h: CGFloat = 0.0
        var s: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        if self.getHue(&h, saturation: &s, brightness: &b, alpha: &a) {
            return UIColor(hue: h, saturation: s, brightness: b * 1.25, alpha: a)
        }
        
        return UIColor.whiteColor()
    }
    
}

// MARK: - UITextField
extension UITextField {
    func makeRoundBorder() {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 1.0
    }
    
    func makeRoundBorder(color: UIColor) {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = 1.0
    }
    
    func changePlaceholderColorTo(color:UIColor) {
        if let ph = self.placeholder {
            self.attributedPlaceholder = NSAttributedString(string: ph, attributes: [NSForegroundColorAttributeName: color])
        }
    }
}

// MARK: - UIImage
// IN PHOTOMASTER

// MARK: - UIImageView
extension UIImageView {
    func makeBorderedCircle() {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.blackColor().CGColor
    }
}

extension UIImageView {
    func asyncImageWithURL(url: String?) {
        guard url != nil else {
            return
        }
        
        Alamofire.request(.GET, url!).responseImage { (response) -> Void in
            if let imageResult = response.result.value {
                self.image = imageResult
            }
        }
    }
}

//MARK: - UINavigationBar
extension UINavigationBar {
    
    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = true
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = false
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}

// MARK: - UIViewController
extension UIViewController {
    
    func addConstraintToView(constraint: NSLayoutConstraint) {
        self.view.addConstraint(constraint)
    }
    
    /**
     Helper for add width and height to an item. The item must be the subview of self.view.
     
     - parameter item:   The target item view
     - parameter width:  Width
     - parameter height: Height
     
     - returns: Return the created width and height layoutConstraint object
     */
    func addWidthAndHeightConstraintToItem(item: UIView?, width: CGFloat, height: CGFloat) -> (widthConstraint: NSLayoutConstraint, heightConstraint: NSLayoutConstraint) {
        let widthConstr = ConstraintBlower.width(item, width: width)
        let heightConstr = ConstraintBlower.height(item, height: height)
        self.addConstraintToView(widthConstr)
        self.addConstraintToView(heightConstr)
        return (widthConstr, heightConstr)
    }
    
    /**
     Make these items align to the self.view's center horizontally
     
     - parameter items: All target item view on self.view
     */
    func addItemsAllAlignToCenterXConstraints(items: [UIView?]?) {
        guard items != nil else {
            print("## makeItemsAllAlignToCenterX items is nil")
            return
        }
        
        for item in items! {
            self.view.addConstraint(ConstraintBlower.centerX(item, toItem: self.view))
        }
    }
    
    /**
     Originally using visual format language: "V:|-32-[label]-22-[list]-15-[textView]-20-[button]".
     Now just put the gaps number and ViewController.view will generate constraint with visual format language itself
     
     @parameter gapConstants: An array of gaps of subviews from top of the self.view
     */
    func addVerticalGapConstraintsToAllSubviews(gapConstants: [CGFloat]) {
        var viewsDictionary: [String : UIView] = [String : UIView]()
        var visualFormatString = "V:|"
        var index = 0
        
        for subview in self.view.subviews {
            if !subview.hidden {
                let viewKey = "_\(index)_subview"
                
                viewsDictionary[viewKey] = subview
                
                visualFormatString += "-\(gapConstants[index])-[\(viewKey)]"
                
                index += 1
            }
        }
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(visualFormatString, options: [], metrics: nil, views: viewsDictionary))
    }
    
}

extension UIViewController {
    /**
     Generate an empty HiveList object and add to view
     
     - returns: The HiveList object
     */
    func genHiveListToSelf() -> HiveList {
        let list: HiveList = HiveList()
        list.frame = CGRectMake(0, 0, 0, 0)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(list)
        return list
    }
}

extension UIViewController {
    func dismissNow () {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func popNow() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}

// MARK: AlertView Helper
extension UIViewController {
    
    func showAlertWithOptions(target: UIViewController, alertTitle:String, msg:String, okAction:(okAlertAction: UIAlertAction)->Void, usingCancel: Bool) {
        
        let alert = UIAlertController(title: alertTitle, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            okAction(okAlertAction: action)
        }
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            
        }
        
        alert.addAction(ok)
        if usingCancel {
            alert.addAction(cancel)
        }
        
        target.presentViewController(alert, animated: true) { () -> Void in
            
        }
    }
    
    func showAlertWithOptions(target: UIViewController, alertTitle:String, msg:String, alertAction:(alertAction: Bool)->Void, usingCancel: Bool) {
        
        let alert = UIAlertController(title: alertTitle, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            alertAction(alertAction: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (action) -> Void in
            alertAction(alertAction: false)
            
        }
        
        alert.addAction(ok)
        if usingCancel {
            alert.addAction(cancel)
        }
        
        target.presentViewController(alert, animated: true) { () -> Void in
            
        }
    }
    
}

// STORYBOARD HELPER
extension UIViewController {
    class func viewControllerWithStoryboardId(identifier: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(identifier)
    }
    
    func viewControllerStoryboard(storyboardName: String, identifier: String) -> UIViewController {
        return UIStoryboard(name: storyboardName, bundle: nil).instantiateViewControllerWithIdentifier(identifier)
    }
}

extension UIViewController {
    func showAlertWithTextField(title: String?, message: String?, textFieldConfiguration:(textField: UITextField) -> Void, okAction:(action: UIAlertAction, text: String?) -> Void, cancelAction:(action: UIAlertAction) -> Void) {
        
        let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textFieldConfiguration(textField: textField)
        }
        
        let alertAction: UIAlertAction = UIAlertAction(title: "確認", style: .Default) { (action) in
            guard alertController.textFields != nil else {
                return
            }
            
            let text = alertController.textFields![0].text
            
            okAction(action: action, text: text)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "取消", style: .Default) { (action) in
            cancelAction(action: action)
        }
        
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) { 
            
        }
    }
}

// MARK: - UITableViewController
extension UITableView {
    func getCellsHeight(section:Int) -> CGFloat {
        return self.rectForSection(section).height
    }
}

// MARK: - CUSTOM CLASSES
class RoundedContainerView: UIView {
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        self.makeRounded(6)
    }
    
}

class Image: NSObject {
    class func this(name: String) -> UIImage {
        return UIImage(named: name)!
    }
}

class ConstraintBlower: NSObject {
    
    class func height(item: UIView?, height: CGFloat) -> NSLayoutConstraint {
        let constr = NSLayoutConstraint(item: item!, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: height)
        return constr
    }
    
    class func topToTop(item: UIView?, toItem: UIView?, distance: CGFloat) -> NSLayoutConstraint {
        let constr = NSLayoutConstraint(item: item!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toItem!, attribute: NSLayoutAttribute.Top, multiplier: 1.0, constant: distance)
        return constr
    }
    
    class func topToBottom(item: UIView?, toItem: UIView?, distance: CGFloat) -> NSLayoutConstraint {
        let constr = NSLayoutConstraint(item: item!, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: toItem, attribute: NSLayoutAttribute.Bottom, multiplier: 1.0, constant: distance)
        return constr
    }
    
    class func width(item: UIView?, width: CGFloat) -> NSLayoutConstraint {
        let constr = NSLayoutConstraint(item: item!, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: width)
        return constr
    }
    
    class func centerX(item: UIView?, toItem: UIView?) -> NSLayoutConstraint {
        let constr = NSLayoutConstraint(item: item!, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: toItem!, attribute: NSLayoutAttribute.CenterX, multiplier: 1.0, constant: 0.0)
        return constr
    }
    
}



