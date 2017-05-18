//
//  CircleSliderControllerViewController.swift
//  JanuaryFirst
//
//  Created by Alpaca on 2017. 5. 19..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit
import CircleSlider


class CircleSliderControllerViewController: UIViewController {
    
    @IBOutlet weak var sliderArea: UIView!
        
        private var circleSlider: CircleSlider! {
            didSet {
                self.circleSlider.tag = 0
            }
        }
    
        private var valueLabel: UILabel!
        private var progressLabel: UILabel!
        private var timer: Timer?
        private var sliderOptions: [CircleSliderOption] {
            return [
                CircleSliderOption.barColor(UIColor(red: 198/255, green: 244/255, blue: 23/255, alpha: 1)),
                CircleSliderOption.thumbColor(UIColor(red: 141/255, green: 185/255, blue: 204/255, alpha: 1)),
                CircleSliderOption.trackingColor(UIColor(red: 78/255, green: 136/255, blue: 185/255, alpha: 1)),
                CircleSliderOption.barWidth(20),
                CircleSliderOption.startAngle(-45),
                CircleSliderOption.maxValue(150),
                CircleSliderOption.minValue(20),
                //CircleSliderOption.thumbImage(UIImage(named: "thumb_image")!)
            ]
        }
        private var progressOptions: [CircleSliderOption] {
            return [
                .barColor(UIColor(red: 255/255, green: 190/255, blue: 190/255, alpha: 0.3)),
                .trackingColor(UIColor(red: 159/255, green: 0/255, blue: 0/255, alpha: 1)),
                .barWidth(30),
                .sliderEnabled(false)
            ]
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.buildCircleSlider()
        }
        
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            self.circleSlider.frame = self.sliderArea.bounds
            self.valueLabel.center = CGPoint(x: self.circleSlider.bounds.width * 0.5, y: self.circleSlider.bounds.height * 0.5)
        }
        
        private func buildCircleSlider() {
            self.circleSlider = CircleSlider(frame: self.sliderArea.bounds, options: self.sliderOptions)
            self.circleSlider?.addTarget(self, action: #selector(valueChange(sender:)), for: .valueChanged)
            self.sliderArea.addSubview(self.circleSlider!)
            self.valueLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            self.valueLabel.textAlignment = .center
            self.circleSlider.addSubview(self.valueLabel)
        }
    
        func valueChange(sender: CircleSlider) {
            switch sender.tag {
            case 0:
                self.valueLabel.text = "\(Int(sender.value))"

            default:
                break
            }
        }
    
}
