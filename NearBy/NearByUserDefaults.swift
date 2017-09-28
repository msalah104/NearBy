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
    
    class func getCachedPlaces() -> [Place]{
        
        if let archivedPlaces = defaults.object(forKey: Constants.CACH_PLACES) {
            let places:[Place] = NSKeyedUnarchiver.unarchiveObject(with: archivedPlaces as! Data) as! [Place]
            return places
        } else {
            // Default state is single time update
            return [Place]()
        }
    }
    
    
    class func setCachedPlaces(_ places:[Place]){
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: places)
        
        defaults.set(encodedData, forKey: Constants.CACH_PLACES)
        
        
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
