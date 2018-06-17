//
//  Video.swift
//  Youtube
//
//  Created by Noshaid Ali on 10/3/17.
//  Copyright © 2017 Cricingif. All rights reserved.
//

import UIKit

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        //handle crash if new key is added in api response
        let uppercasedFirstCharacter = String(key.first!).uppercased()
        let range = key.startIndex...key.startIndex.advanced(by: 0)
        let selectorString = key.replacingCharacters(in: range, with: uppercasedFirstCharacter)
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        if !responds {
            return
        }
        super.setValue(value, forKey: key)
    }
}

class Video: SafeJsonObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    var uploadDate: Date?
    var duration: NSNumber?
    var channel:Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel" {
            let channelDictionary = value as! [String:AnyObject]
            self.channel = Channel()
            self.channel?.setValuesForKeys(channelDictionary)
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String: Any]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}

class Channel: SafeJsonObject {
    
    var name: String?
    var profile_image_name: String?
}
