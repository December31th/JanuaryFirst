//
//  IntroViewController.swift
//  
//
//  Created by LEOFALCON on 2017. 4. 8..
//
//

import UIKit

class IntroViewController: UIViewController {

    @IBOutlet var mainCopy: UILabel!
    @IBOutlet var start: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCopy.text = NSLocalizedString("mainCopy", comment: "mainCopy")
            start.text = NSLocalizedString("start", comment: "start")
        mainCopy.textColor = Color.dimFontColor
        self.view.backgroundColor = UIColor.white
    }
}
