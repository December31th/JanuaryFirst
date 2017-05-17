//
//  NotiView.swift
//  test
//
//  Created by Alpaca on 2017. 2. 15..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit

class NotiView: UIView {
    @IBOutlet var save: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        addBehavior()
    }
    func addBehavior(){
        self.save.text = "save"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

