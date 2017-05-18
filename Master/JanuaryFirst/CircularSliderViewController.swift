//
//  CircularSliderViewController.swift
//  JanuaryFirst
//
//  Created by Alpaca on 2017. 5. 19..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit
import CircularSlider

class CircularSliderViewController: UIViewController {
    
    var arrNum: Int?
    var getMonArr = makeArrForTable(month: selectedDateInMonthView)
    var dayArr = [Date]()
    
    // MARK: - outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var circularSlider: CircularSlider!
    
    // MARK: - view lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCircularSlider()
        registerForKeyboardNotifications()
        setupTapGesture()
        getMonArr = makeArrForTable(month: selectedDateInMonthView)
        for index in dayArr.indices{
            dayArr.append(getMonArr[index].date)
        }
        
    }
    
    @IBAction func sendCircleValue(_ sender: Any) {
        dataCenter.days[0].dayArr[148].diary1.rate = Int(circularSlider.value)
        dataCenter.save()
    }
    
    
    // MARK: - methods
    fileprivate func setupCircularSlider() {
        circularSlider.delegate = self as? CircularSliderDelegate
    }
    
    fileprivate func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    // MARK: - keyboard handler
    fileprivate func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil )
    }
    
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        adjustInsetForKeyboardShow(true, notification: notification)
    }
    
    @objc fileprivate func keyboardWillHide(_ notification: Notification) {
        adjustInsetForKeyboardShow(false, notification: notification)
    }
    
    fileprivate func adjustInsetForKeyboardShow(_ show: Bool, notification: Notification) {
        guard let value = (notification as NSNotification).userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
        let keyboardFrame = value.cgRectValue
        let adjustmentHeight = (keyboardFrame.height + 150) * (show ? 1 : -1)
        scrollView.contentInset.bottom += adjustmentHeight
        scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    
    @objc fileprivate func hideKeyboard() {
        view.endEditing(true)
    }
    
    
    // MARK: - actions
    @IBAction func decrementAction(_ sender: UIButton) {
        circularSlider.setValue(circularSlider.value - 50, animated: true)
    }
    
    @IBAction func incrementAction(_ sender: UIButton) {
        circularSlider.setValue(circularSlider.value + 50, animated: true)
    }
}


// MARK: - CircularSliderDelegate
extension ViewController: CircularSliderDelegate {
    func circularSlider(_ circularSlider: CircularSlider, valueForValue value: Float) -> Float {
        return floorf(value)
    }
}
