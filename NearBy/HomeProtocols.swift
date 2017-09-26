//
//  HomeProtocols.swift
//  NearBy
//
//  Created by Orange Labs Cairo on 9/21/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit

// Protocol to all state for the home view
protocol HomeViewDelegate {
    
    // Loading
    func startLoading()
    func finishLoading()
    
    // Error
    func someThingWrongHappend()
    func noNearPlaces()
    
    // UpdateData
    
    
}
