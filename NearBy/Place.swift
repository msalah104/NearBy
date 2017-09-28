//
//  Place.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/22/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit

class Place: NSObject, NSCoding {

    var id:String?
    var name:String?
    var imageUrl:String?
    var address1:String?
    var address2:String?
    var address3:String?
    var address4:String?
    
    
    required init(id:String="", name:String="", imageUrl:String="", address1:String="",
                  address2:String="", address3:String="", address4:String="") {
        self.name = name
        self.id = id
        self.imageUrl = imageUrl
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
        self.address4 = address4
    }
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.id = decoder.decodeObject(forKey: "id") as? String ?? ""
        self.imageUrl = decoder.decodeObject(forKey: "imageUrl") as? String ?? ""
        self.address1 = decoder.decodeObject(forKey: "address1") as? String ?? ""
        self.address2 = decoder.decodeObject(forKey: "address2") as? String ?? ""
        self.address3 = decoder.decodeObject(forKey: "address3") as? String ?? ""
        self.address4 = decoder.decodeObject(forKey: "address4") as? String ?? ""
        
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey:"Name")
        coder.encode(id, forKey:"id")
        coder.encode(imageUrl, forKey:"imageUrl")
        coder.encode(address1, forKey:"address1")
        coder.encode(address2, forKey:"address2")
        coder.encode(address3, forKey:"address3")
        coder.encode(address4, forKey:"address4")
        
    }
    
}
