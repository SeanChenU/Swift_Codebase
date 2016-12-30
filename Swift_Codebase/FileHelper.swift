//
//  FileHelper.swift
//  Swift_Codebase
//
//  Created by Sean Chen on 2015/12/3.
//  Copyright © 2015年 Rings. All rights reserved.
//
import UIKit
import Foundation

class FileHelper: NSObject {
    
    static let sharedInstance = FileHelper()
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    func getFilePathInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL!.path!
    }
    
    /**
    Get UIImage by path
    
    - parameter path: File path
    
    - returns: UIImage
    */
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
        
    }
    
    func listFilesInDocumentFolder() -> [String] {
        let dirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
        
        let dir = dirs[0]
        do {
            let fileList = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(dir)
            return fileList as [String]
        }catch {
            
        }
        
        let fileList = [""]
        return fileList
    }
    
    func removeAllFilesInDocumentFolder() {
        
        let fileManager = NSFileManager.defaultManager()
        
        for file in listFilesInDocumentFolder() {
            do {
                try fileManager.removeItemAtPath(getFilePathInDocumentsDirectory(file))
            } catch {
                
            }
        }
        
        print("After cleanup document folder: \(listFilesInDocumentFolder())")
    }
    
    func getStringFromTextFile(fileName: String, type: String) -> String {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: type)
        do {
            let text = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            return text
        } catch {
            print("Read file from bundle exception")
        }
        return ""
    }
}
