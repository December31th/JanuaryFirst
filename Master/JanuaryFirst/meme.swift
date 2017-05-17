//
//  meme.swift
//  test
//

//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import Foundation
import UIKit


class UserSetting: NSObject, NSCoding {
    var goal1 : String?
    var goal2 : String?
    var goal3 : String?
    
    override init() {
        self.goal1 = nil
        self.goal2 = nil
        self.goal3 = nil
    }
    
    required init?(coder aDecoder : NSCoder) {
        self.goal1 = aDecoder.decodeObject(forKey : "goal1") as? String
        self.goal2 = aDecoder.decodeObject(forKey : "goal2") as? String
        self.goal3 = aDecoder.decodeObject(forKey : "goal3") as? String
    }
    func encode(with aCoder : NSCoder)  {
        aCoder.encode(self.goal1,forKey : "goal1")
        aCoder.encode(self.goal1,forKey : "goal2")
        aCoder.encode(self.goal1,forKey : "goal3")
    }
}
