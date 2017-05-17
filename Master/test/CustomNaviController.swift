//
//  CustomNaviController.swift
//  test
//
//  Created by cscoi009 on 2017. 1. 31..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit

class CustomNaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavigationBar() {
        let bar:UINavigationBar! = self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), for:UIBarMetrics.default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor.black
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
