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