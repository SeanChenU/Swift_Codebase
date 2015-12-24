//
//  ViewControllerUtil.swift
//  Swift_Codebase
//
//  Created by Sean Chen on 2015/12/11.
//  Copyright © 2015年 Rings. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerUtil {
    
}

// MARK: Find tableView cells accumulated height
extension ViewControllerUtil {
    
    class func getCellsHeight(tableView: UITableView, section:Int) -> CGFloat {
        return tableView.rectForSection(section).height
    }
    
}

// MARK: AlertView Helper
extension UIViewController {
    
    func showAlertWithOptions(target: UIViewController, alertTitle:String, msg:String, okAction:()->Void, usingCancel: Bool) {
        
        let alert = UIAlertController(title: alertTitle, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action) -> Void in
            okAction()
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
    
}