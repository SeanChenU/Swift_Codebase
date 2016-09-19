//
//  LocationObject.swift
//  vetcare-ios
//
//  Created by SEAN HD on 2016/7/19.
//  Copyright © 2016年 IgnioLab. All rights reserved.
//

import Foundation
import SwiftyJSON

class LocationObject: NSObject {
    var coordinate: CLLocationCoordinate2D
    var address: String
    
    required init(coordinate: CLLocationCoordinate2D, address: String) {
        self.coordinate = coordinate
        self.address = address
    }
    
    internal class func objectFromJSON(locationJSON: JSON) -> LocationObject {
        let loc = locationJSON["loc"]
        let coordinate = CLLocationCoordinate2D(latitude: loc["lat"].numberValue.doubleValue, longitude: loc["lng"].numberValue.doubleValue)
        let address = locationJSON["text"].stringValue
        return LocationObject(coordinate: coordinate, address: address)
    }
    
    internal func changeAddress(newAddress: String, completion:(newLocObject: LocationObject?) -> Void ) {
        LocationMaster.sharedInstance.geoCode(newAddress) { (locationObject) in
            if locationObject != nil {
                self.coordinate = locationObject!.coordinate
                self.address = locationObject!.address
                
                completion(newLocObject: locationObject)
            } else {
                completion(newLocObject: nil)
            }
        }
    }
    
    internal func toDict() -> [String: AnyObject] {
        return ["text": self.address, "loc": ["lat": self.coordinate.latitude, "lng": self.coordinate.longitude]]
    }
    
    internal func toJSONString() -> String? {
        return JSON(self.toDict()).rawString(NSUTF8StringEncoding, options: NSJSONWritingOptions.PrettyPrinted)
    }
    
    override var description: String {
        return "<LocationObject> lat: \(self.coordinate.latitude), lng: \(self.coordinate.longitude), address: \(self.address)"
    }
}