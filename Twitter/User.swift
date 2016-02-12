//
//  User.swift
//  Twitter
//
//  Created by Yousef Kazerooni on 2/11/16.
//  Copyright © 2016 Yousef Kazerooni. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var tagline: String?
    //for fun we will also include the actual dictionary
    var dictionary: NSDictionary
    
    init( dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_Url"] as? String
        tagline = dictionary["description"] as? String
    }

}