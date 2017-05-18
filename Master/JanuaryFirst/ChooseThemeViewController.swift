//
//  ChooseThemeViewController.swift
//  JanuaryFirst
//
//  Created by LEOFALCON on 2017. 5. 18..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit

class ChooseThemeViewController: UIViewController {

    @IBOutlet var whichThemeDescription: UILabel!
    @IBOutlet var plzSetDescription: UILabel!
    @IBOutlet var setWhite: UIButton!
    @IBOutlet var setBlack: UIButton!
    var theme : Int = 0 // 1 : white 2 : black
    
    @IBAction func setWhite(_ sender: Any) {
        self.theme = 1 //set white
    }
    
    @IBAction func setBlack(_ sender: Any) {
        self.theme = 2 // set black
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.backGroundColor
        

    }
    @IBAction func saveTheme(_ sender: Any) {
        switch theme {
        case 1 :
            Color.setWhite()
            UserDefaults.standard.set(1, forKey: "theme")
            let tbController = self.storyboard?.instantiateViewController(withIdentifier: "root") as! UITabBarController
            tbController.tabBar.tintColor = Color.deepLineColor
            tbController.tabBar.barTintColor = Color.backGroundColor

        case 2 :
            Color.setBlack()
            UserDefaults.standard.set(2, forKey: "theme")
            let tbController = self.storyboard?.instantiateViewController(withIdentifier: "root") as! UITabBarController
            tbController.tabBar.tintColor = Color.deepLineColor
            tbController.tabBar.barTintColor = Color.backGroundColor

        default:
            print("error")
            return
        }
    
    }

}
