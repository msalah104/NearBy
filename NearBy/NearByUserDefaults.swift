//
//  NearByUserDefaults.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/22/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit

class NearByUserDefaults: NSObject {

    // Declare the defaults
    static let defaults:UserDefaults = UserDefaults.standard
    
    class func setCurrentUpdateMode(_ updateMode:PlacesUpdateType){
        defaults.set(updateMode.rawValue, forKey: Constants.UPDATE_MODE)
        
        
    }
    
    class func getCurrentUpdateMode() -> PlacesUpdateType{
        
        if let mode = defaults.object(forKey: Constants.UPDATE_MODE) {
            return PlacesUpdateType(rawValue: mode as! String)!
        } else {
            // Default state is single time update
            return .SingleTime
        }
    }
}
