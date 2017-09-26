//
//  Constants.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/22/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit

struct Constants {
    
   // Configurations
   static let DEFAULT_SEARCH_RADIUS = 1000.0
   static let DEFAULT_UPDATE_DISTANCE = 500.0
    
   // Constants
    static let UPDATE_MODE = "Places_Update_Mode"
    static let SUCCESS:Int = 200
  
    // URL
    static let BASE_URL = "https://api.foursquare.com/v2/venues/explore?v=20131016&ll="
    static let BASE_IMAGE_URL = "https://api.foursquare.com/v2/venues/"
    static let URL_CLIENT_ID = "&client_id="
    static let URL_CLIENT_SECRET = "&client_secret="
    static let URL_RADIUS = "&radius="
    
    // Keys file
    static let CLIENT_ID = "CLIENT_ID"
    static let CLIENT_SECRET = "CLIENT_SECRET"
    
}
