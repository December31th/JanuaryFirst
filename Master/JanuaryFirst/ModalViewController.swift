//
//  ModalViewController.swift
//  test
//
//  Created by cscoi009 on 2017. 1. 31..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit
import AKPickerView_Swift
import JTAppleCalendar
import StatusBarNotificationCenter

class ModalViewController: UIViewController, UITextViewDelegate,UITextFieldDelegate, AKPickerViewDataSource, AKPickerViewDelegate {
    
    var arrNum : Int?
    var diary1 : Diary?
    var diary2 : Diary?
    var diary3 : Diary?
    var varDate : String = ""
    var varMonth : String = ""
    var rate : Int = 0
    let calendar = Calendar.current
    
    @IBOutlet var saveDiary: UIButton!
    //첫번째 목표
    @IBOutlet var AllGoal1: UIView!
    @IBOutlet weak var goal1: UILabel!
    @IBOutlet weak var goal1Rate: UITextField!
    @IBOutlet weak var goal1Content: UITextView!
    @IBOutlet weak var placeHolderLabel: UILabel!
    @IBOutlet var percent1: UILabel!
    //두번째 목표
    @IBOutlet var AllGoal2: UIView!
    @IBOutlet weak var goal2: UILabel!
    @IBOutlet weak var goal2Rate: UITextField!
    @IBOutlet weak var goal2Content: UITextView!
    @IBOutlet weak var placeHolderLabel2: UILabel!
    @IBOutlet var percent2: UILabel!
    //세번째 목표
    @IBOutlet var AllGoal3: UIView!
    @IBOutlet weak var goal3: UILabel!
    @IBOutlet weak var goal3Rate: UITextField!
    @IBOutlet weak var goal3Content: UITextView!
    @IBOutlet weak var placeHolderLabel3: UILabel!
    @IBOutlet var percent3: UILabel!
    
    @IBOutlet var month: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet weak var pickerView: AKPickerView!
    // 날짜별 점 세개 표시
    // 오늘
    @IBOutlet weak var todayGoal1: UIView!
    @IBOutlet weak var todayGoal2: UIView!
    @IBOutlet weak var todayGoal3: UIView!
    // 어제
    @IBOutlet weak var yesterdayGoal1: UIView!
    @IBOutlet weak var yesterdayGoal2: UIView!
    @IBOutlet weak var yesterdayGoal3: UIView!
    @IBOutlet weak var goYesterday: UIButton!
    // 내일
    @IBOutlet weak var tomorrowGoal1: UIView!
    @IBOutlet weak var tomorrowGoal2: UIView!
    @IBOutlet weak var tomorrowGoal3: UIView!
    @IBOutlet weak var goTomorrow: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var getMonArr = makeArrForTable(month: selectedDateInMonthView)
    var dayArr = [Date]()
    var stringDayArr = [String]()
    var selectedPicker = Date()
    var pickerIndex = Int()
    
    //override var preferredStatusBarStyle: UIStatusBarStyle {
    //    return .lightContent
    //}
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.backGroundColor
        getMonArr = makeArrForTable(month: selectedDateInMonthView)
        goal1Content.backgroundColor = UIColor.clear
        goal1Content.layer.borderColor = Color.dimLineColor.cgColor
        goal1Content.layer.borderWidth = 0.8
        goal1Content.layer.cornerRadius = 0
        goal1Content.textColor = Color.deepFontColor

        goal2Content.backgroundColor = UIColor.clear
        goal2Content.layer.borderColor = Color.dimLineColor.cgColor
        goal2Content.layer.borderWidth = 0.8
        goal2Content.layer.cornerRadius = 0
        goal2Content.textColor = Color.deepFontColor

        goal3Content.backgroundColor = UIColor.clear
        goal3Content.layer.borderColor = Color.dimLineColor.cgColor
        goal3Content.layer.borderWidth = 0.8
        goal3Content.layer.cornerRadius = 0
        goal3Content.textColor = Color.deepFontColor
        
        
        

        // TextField 커서 컬러 바꿈.
        UITextView.appearance().tintColor = Color.deepFontColor
        
        
        if diary2?.name == "" {
            goal2.isHidden = true
            goal2Rate.isHidden = true
            goal2Content.isHidden = true
            AllGoal2.isHidden = true
        }
        else{
            goal2Rate.addBorderBottom(height: 1.0, color: Color.dimLineColor)
            goal2Rate.text = String(describing: (diary2?.rate)!)
            goal2Rate.textColor = Color.deepFontColor
            goal2.text = (diary2?.name)! + " :"
            goal2.textColor = Color.deepFontColor
            goal2Content.text = diary2?.content
            percent2.textColor = Color.dimFontColor
            
            placeHolderLabel2.text = NSLocalizedString("modalPlaceHolder", comment: "modalPlaceHolder")
            placeHolderLabel2.font = UIFont.italicSystemFont(ofSize: (goal2Content.font?.pointSize)!)
            placeHolderLabel2.sizeToFit()
            goal2Content.addSubview(placeHolderLabel2)
            placeHolderLabel2.frame.origin = CGPoint(x:5, y: (goal2Content.font?.pointSize)!/2)
            placeHolderLabel2.textColor = Color.dimFontColor
            
            if (goal2Content.text == "") && (dataCenter.days[0].dayArr[arrNum!].diary2.content == "") {
                placeHolderLabel2.isHidden = false
            } else {
                placeHolderLabel2.isHidden = true
                }
            }
        
        if diary3?.name == "" {
            goal3.isHidden = true
            goal3Rate.isHidden = true
            goal3Content.isHidden = true
            AllGoal3.isHidden = true
        }
        else {
            goal3Rate.addBorderBottom(height: 1.0, color: Color.dimLineColor)
            goal3.text = (diary3?.name)! + " :"
            goal3.textColor = Color.deepFontColor
            goal3Rate.text = String(describing: (diary3?.rate)!)
            goal3Rate.textColor = Color.deepFontColor
            goal3Content.text = diary3?.content
            percent3.textColor = Color.dimFontColor
            
            placeHolderLabel3.text = NSLocalizedString("modalPlaceHolder", comment: "modalPlaceHolder")
            placeHolderLabel3.font = UIFont.italicSystemFont(ofSize: (goal3Content.font?.pointSize)!)
            placeHolderLabel3.sizeToFit()
            goal3Content.addSubview(placeHolderLabel3)
            placeHolderLabel3.frame.origin = CGPoint(x:5, y: (goal3Content.font?.pointSize)!/2)
            placeHolderLabel3.textColor = Color.dimFontColor
            
            if (goal3Content.text == "") && (dataCenter.days[0].dayArr[arrNum!].diary3.content == "") {
                placeHolderLabel3.isHidden = false
            } else {
                placeHolderLabel3.isHidden = true
            }
            self.pickerView.reloadData()
        }
        
        //UITextField 밑줄만 넣기 코드
        goal1Rate.addBorderBottom(height: 1.0, color: Color.dimLineColor)
        date.textColor = Color.deepFontColor
        month.textColor = Color.deepFontColor
        date.text = varDate
        month.text = varMonth[0..<3]
        goal1.text = (diary1?.name)! + " :"
        goal1.textColor = Color.deepFontColor
        goal1Rate.text = String(describing: (diary1?.rate)!)
        goal1Rate.textColor = Color.deepFontColor
        goal1Content.text = diary1?.content
        percent1.textColor = Color.dimFontColor
        /*
        goal1Content.textContainer.maximumNumberOfLines =
        goal1Content.textContainer.lineFragmentPadding = 0
        */
        
        // Placeholder이 글자가 생기면 없어지게 구현!
        goal1Content.delegate = self
        goal2Content.delegate = self
        goal3Content.delegate = self
        
        
        placeHolderLabel.text = NSLocalizedString("modalPlaceHolder", comment: "modalPlaceHolder")
        placeHolderLabel.font = UIFont.italicSystemFont(ofSize: (goal1Content.font?.pointSize)!)
        placeHolderLabel.sizeToFit()
        goal1Content.addSubview(placeHolderLabel)
        placeHolderLabel.frame.origin = CGPoint(x:5, y: (goal1Content.font?.pointSize)!/2)
        placeHolderLabel.textColor = Color.dimFontColor
        
        
        
        if (goal1Content.text == "") && (dataCenter.days[0].dayArr[arrNum!].diary1.content == "")  {
            placeHolderLabel.isHidden = false
        } else {
            placeHolderLabel.isHidden = true
        }
        
        
        
        // PickerView 구현
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d           "
        
        for index in getMonArr.indices{
            dayArr.append(getMonArr[index].date)
        }
        for index in dayArr.indices{
            let makeString = dateFormatter.string(from: dayArr[index])
            stringDayArr.append(makeString)
        }
        //dataCenter.days[0].dayArr[
        self.pickerView.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        self.pickerView.highlightedFont = UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)
        self.pickerView.highlightedTextColor = Color.deepFontColor
        self.pickerView.pickerViewStyle = .wheel
        self.pickerView.maskDisabled = false
        self.pickerView.interitemSpacing = 10.0
        
        self.pickerView.selectItem(passedDaysCount(selectedDate: selectedDateInMonthView )-1, animated: false)
        self.pickerView.reloadData()
        
        self.goal1Content.delegate = self
        self.goal2Content.delegate = self
        self.goal3Content.delegate = self
        self.goal1Rate.delegate = self
        self.goal2Rate.delegate = self
        self.goal3Rate.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)

        
          }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeOberservers()
    }
    func didTapView(gesture: UITapGestureRecognizer) {
        // This should hide keyboard for the view.
        view.endEditing(true)
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil) {
            notification in
            self.keyboardWillShow(notification: notification)
        }
        
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil) {
            notification in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func removeOberservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsetsMake(0, 0, frame.height, 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    @IBAction func viewUp(_ sender: Any) {

    }
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:  if (pickerIndex != 0) {self.pickerView.selectItem(passedDaysCount(selectedDate: selectedPicker)-2, animated: false)}
                
            case UISwipeGestureRecognizerDirection.down:
                break
            case UISwipeGestureRecognizerDirection.left: if pickerIndex != (dayArr.indices.count - 1) {self.pickerView.selectItem(passedDaysCount(selectedDate: selectedPicker), animated: false)}

            case UISwipeGestureRecognizerDirection.up:
                break
            default:
                break
            }   
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == goal3Rate) {
            scrollView.setContentOffset(CGPoint(x:0,y:216), animated: true)
        }
        textField.text = ""
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == goal3Content {
            scrollView.setContentOffset(CGPoint(x:0,y:216), animated: true)
        }
        if textView == goal1Content { placeHolderLabel.isHidden = true}
        if textView == goal2Content { placeHolderLabel2.isHidden = true}
        if textView == goal3Content { placeHolderLabel3.isHidden = true}
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        if textField.text == "" {
            textField.text = "0"
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        if textView == goal1Content && goal1Content.text == "" { placeHolderLabel.isHidden = false}
        if textView == goal2Content && goal2Content.text == "" { placeHolderLabel2.isHidden = false}
        if textView == goal3Content && goal3Content.text == "" { placeHolderLabel3.isHidden = false}
    }
    func passedDaysCount(selectedDate: Date) -> Int {
        let result: Int
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        let ddMake = formatter.string(from: selectedDate)
        result = Int(ddMake)!
        return result
    }
    
    // MARK: - AKPickerViewDataSource
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return self.stringDayArr.count
    }
    
    /*
     
     Image Support
     -------------
     Please comment '-pickerView:titleForItem:' entirely and
     uncomment '-pickerView:imageForItem:' to see how it works.
     
     */
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.stringDayArr[item]
    }
    /*
    func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: self.yearArray[item])
    }
    */
    // MARK: - AKPickerViewDelegate
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        print("Your selected date is \(self.dayArr[item])")
        
        let result = dataCenter.days[0].dayArr.index{$0.date == dayArr[item]}
        pickerIndex = item
        arrNum = result!
        selectedPicker = dayArr[item]
        goal1.text = dataCenter.days[0].dayArr[result!].diary1.name
        goal2.text = dataCenter.days[0].dayArr[result!].diary2.name
        goal3.text = dataCenter.days[0].dayArr[result!].diary3.name
        if dataCenter.days[0].dayArr[result!].diary2.name == "" {
            goal2.isHidden = true
            goal2Rate.isHidden = true
            goal2Content.isHidden = true
            AllGoal2.isHidden = true
        }else{
            goal2.isHidden = false
            goal2Rate.isHidden = false
            goal2Content.isHidden = false
            AllGoal2.isHidden = false
        }
        if dataCenter.days[0].dayArr[result!].diary3.name == "" {
            goal3.isHidden = true
            goal3Rate.isHidden = true
            goal3Content.isHidden = true
            AllGoal3.isHidden = true
        }else{
            goal3.isHidden = false
            goal3Rate.isHidden = false
            goal3Content.isHidden = false
            AllGoal3.isHidden = false
        }
        
        // 피커 날짜에 따른 성취율 받아오기
        if (item >= 0) && (item <= dayArr.indices.count) {
            if let getGoal1Rate = dataCenter.days[0].dayArr[result!].diary1.rate {
            goal1Rate.text = String(getGoal1Rate)
            } else {
            goal1Rate.text = "0"
            }
            if let getGoal2Rate = dataCenter.days[0].dayArr[result!].diary2.rate {
            goal2Rate.text = String(getGoal2Rate)
            } else {
            goal2Rate.text = "0"
            }
            if let getGoal3Rate = dataCenter.days[0].dayArr[result!].diary3.rate {
            goal3Rate.text = String(getGoal3Rate)
            } else {
            goal3Rate.text = "0"
            }
            // 피커 날짜에 따른 콘텐트 받아오기
            if let getGoal1Content = dataCenter.days[0].dayArr[result!].diary1.content {
            goal1Content.text = getGoal1Content
            } else {
            goal1Content.text = ""
            }
            if let getGoal2Content = dataCenter.days[0].dayArr[result!].diary2.content {
                goal2Content.text = getGoal2Content
            } else {
            goal2Content.text = ""
            }
            if let getGoal3Content = dataCenter.days[0].dayArr[result!].diary3.content {
            goal3Content.text = getGoal3Content
            } else {
            goal3Content.text = ""
            }
        }
        // 피커뷰 아래 점표시
        // 오늘 표시
        todayGoal1.layer.cornerRadius = 4
        todayGoal2.layer.cornerRadius = 4
        todayGoal3.layer.cornerRadius = 4
        
        let todayGoal1Colour = dataCenter.days[0].dayArr[result!].diary1.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result!].diary1.rate)!) * 0.009 + 0.1))
        let todayGoal2Colour = dataCenter.days[0].dayArr[result!].diary2.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result!].diary2.rate)!) * 0.009 + 0.1))
        let todayGoal3Colour = dataCenter.days[0].dayArr[result!].diary3.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result!].diary3.rate)!) * 0.009 + 0.1))
        
        todayGoal1.backgroundColor = todayGoal1Colour
        todayGoal2.backgroundColor = todayGoal2Colour
        todayGoal3.backgroundColor = todayGoal3Colour
        
        // 어제 표시
        if item <= 0 {
            yesterdayGoal1.isHidden = true
            yesterdayGoal2.isHidden = true
            yesterdayGoal3.isHidden = true
            goYesterday.isHidden = true
            self.pickerView.reloadData()
        } else {
            yesterdayGoal1.isHidden = false
            yesterdayGoal2.isHidden = false
            yesterdayGoal3.isHidden = false
            goYesterday.isHidden = false
            self.pickerView.reloadData()
        }
        yesterdayGoal1.layer.cornerRadius = 4
        yesterdayGoal2.layer.cornerRadius = 4
        yesterdayGoal3.layer.cornerRadius = 4
        
        let yesterdayGoal1Colour = dataCenter.days[0].dayArr[result!-1].diary1.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result!-1].diary1.rate)!) * 0.009 + 0.1))
        let yesterdayGoal2Colour = dataCenter.days[0].dayArr[result!-1].diary2.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result!-1].diary2.rate)!) * 0.009 + 0.1))
        let yesterdayGoal3Colour = dataCenter.days[0].dayArr[result!-1].diary3.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result!-1].diary3.rate)!) * 0.009 + 0.1))
        
        yesterdayGoal1.backgroundColor = yesterdayGoal1Colour
        yesterdayGoal2.backgroundColor = yesterdayGoal2Colour
        yesterdayGoal3.backgroundColor = yesterdayGoal3Colour
        
            self.pickerView.reloadData()
        
        
        // 내일 표시
        if item >= dayArr.indices.count - 1 {
            tomorrowGoal1.isHidden = true
            tomorrowGoal2.isHidden = true
            tomorrowGoal3.isHidden = true
            goTomorrow.isHidden = true
            self.pickerView.reloadData()
        } else {
            tomorrowGoal1.isHidden = false
            tomorrowGoal2.isHidden = false
            tomorrowGoal3.isHidden = false
            goTomorrow.isHidden = false
            self.pickerView.reloadData()
        }
        tomorrowGoal1.layer.cornerRadius = 4
        tomorrowGoal2.layer.cornerRadius = 4
        tomorrowGoal3.layer.cornerRadius = 4
        
        let tomorrowGoal1Colour = dataCenter.days[0].dayArr[result!+1].diary1.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result!+1].diary1.rate)!) * 0.009 + 0.1))
        let tomorrowGoal2Colour = dataCenter.days[0].dayArr[result!+1].diary2.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result!+1].diary2.rate)!) * 0.009 + 0.1))
        let tomorrowGoal3Colour = dataCenter.days[0].dayArr[result!+1].diary3.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result!+1].diary3.rate)!) * 0.009 + 0.1))
        
        tomorrowGoal1.backgroundColor = tomorrowGoal1Colour
        tomorrowGoal2.backgroundColor = tomorrowGoal2Colour
        tomorrowGoal3.backgroundColor = tomorrowGoal3Colour
            self.pickerView.reloadData()
        
        // 날짜가 바뀌었을 때 PlaceHolder 적용.
        if (goal1Content.text == "") && (dataCenter.days[0].dayArr[arrNum!].diary1.content == "")  {
            placeHolderLabel.isHidden = false
        } else {
            placeHolderLabel.isHidden = true
        }
        if (goal2Content.text == "") && (dataCenter.days[0].dayArr[arrNum!].diary2.content == "") {
            placeHolderLabel2.isHidden = false
        } else {
            placeHolderLabel2.isHidden = true
        }
        if (goal3Content.text == "") && (dataCenter.days[0].dayArr[arrNum!].diary3.content == "") {
            placeHolderLabel3.isHidden = false
        } else {
            placeHolderLabel3.isHidden = true
        }
        
        // 점 날짜별로 불러오기.
        
        
        
        self.pickerView.reloadData()
        return
    }
    /*
     
     Label Customization
     -------------------
     You can customize labels by their any properties (except for fonts,)
     and margin around text.
     These methods are optional, and ignored when using images.
     
     */
    
    
     func pickerView(pickerView: AKPickerView, configureLabel label: UILabel, forItem item: Int) {
     label.textColor = UIColor.white
     label.highlightedTextColor = UIColor.yellow
     label.backgroundColor = UIColor(hue: CGFloat(item) / CGFloat(self.stringDayArr.count),saturation: 1.0,brightness: 0.7, alpha: 1.0)
     }
     func pickerView(pickerView: AKPickerView, marginForItem item: Int) -> CGSize {
    
     return CGSize(width: 100.0, height: 500.0)
     }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // println("\(scrollView.contentOffset.x)")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
 }
    
    func textViewDidChange(_ textView: UITextView) {
        if (goal1Content.text == "") && (dataCenter.days[0].dayArr[arrNum!].diary1.content == "")  {
            placeHolderLabel.isHidden = false
        } else {
            placeHolderLabel.isHidden = true
        }
        if (goal2Content.text == "") && (dataCenter.days[0].dayArr[arrNum!].diary2.content == "") {
            placeHolderLabel2.isHidden = false
        } else {
            placeHolderLabel2.isHidden = true
        }
        if (goal3Content.text == "") && (dataCenter.days[0].dayArr[arrNum!].diary3.content == "") {
            placeHolderLabel3.isHidden = false
        } else {
            placeHolderLabel3.isHidden = true
        }
        
    }
    
    
    
    @IBAction func SaveDiary(_ sender: Any) {
        if goal1Rate.text == "" {goal1Rate.text = "0"}
        if goal2Rate.text == "" {goal2Rate.text = "0"}
        if goal3Rate.text == "" {goal3Rate.text = "0"}
        
        if  ((Int(goal1Rate.text!)! > 100) || (Int(goal1Rate.text!)! < 0)) || ((Int(goal2Rate.text!)! > 100) || (Int(goal2Rate.text!)! < 0)) || ((Int(goal3Rate.text!)! > 100) || (Int(goal3Rate.text!)! < 0)) {
            let rateError = UIAlertController(title: NSLocalizedString("error", comment: "error"), message: NSLocalizedString("error_incorrect_data", comment: "error_incorrect_data"), preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.default, handler: {(ACTION) in return})
            rateError.addAction(okAction)
            self.present(rateError, animated: true, completion: nil)
        } else{
            
            let beforeRate1 = dataCenter.days[0].dayArr[arrNum!].diary1.rate
            let beforeRate2 = dataCenter.days[0].dayArr[arrNum!].diary2.rate
            let beforeRate3 = dataCenter.days[0].dayArr[arrNum!].diary3.rate
            
            let beforeContent1 = dataCenter.days[0].dayArr[arrNum!].diary1.content
            let beforeContent2 = dataCenter.days[0].dayArr[arrNum!].diary2.content
            let beforeContent3 = dataCenter.days[0].dayArr[arrNum!].diary3.content
            
            checkIsDifferent(
                beforeRate1: beforeRate1!, afterRate1: goal1Rate.text!,
                beforeRate2: beforeRate2!, afterRate2: goal2Rate.text!,
                beforeRate3: beforeRate3!, afterRate3: goal3Rate.text!,
                beforeContent1: beforeContent1!, afterContent1: goal1Content.text,
                beforeContent2: beforeContent2!, afterContent2: goal2Content.text,
                beforeContent3: beforeContent3!, afterContent3: goal3Content.text
            )

            
            dataCenter.days[0].dayArr[arrNum!].diary1.rate = Int(goal1Rate.text!)!
            dataCenter.days[0].dayArr[arrNum!].diary2.rate = Int(goal2Rate.text!)!
            dataCenter.days[0].dayArr[arrNum!].diary3.rate = Int(goal3Rate.text!)!
        
            dataCenter.days[0].dayArr[arrNum!].diary1.content = goal1Content.text
            dataCenter.days[0].dayArr[arrNum!].diary2.content = goal2Content.text
            dataCenter.days[0].dayArr[arrNum!].diary3.content = goal3Content.text
        
            dataCenter.save()
            self.presentingViewController?.dismiss(animated: true)
        }
    }
    
    func checkIsDifferent(beforeRate1 : Int, afterRate1 : String, beforeRate2 : Int, afterRate2 : String,beforeRate3 : Int, afterRate3 : String, beforeContent1 : String, afterContent1 : String, beforeContent2 : String, afterContent2 : String, beforeContent3 : String, afterContent3 : String  ) {
        var check = 0 // 0 이면 no Change
        if beforeRate1 != Int(afterRate1) {check = 1}
        if beforeRate2 != Int(afterRate2) {check = 1}
        if beforeRate3 != Int(afterRate3) {check = 1}
        if beforeContent1 != afterContent1 {check = 1}
        if beforeContent2 != afterContent2 {check = 1}
        if beforeContent3 != afterContent3 {check = 1}
        
        if check == 1 {
            var notificationCenterConfiguration = NotificationCenterConfiguration(baseWindow: view.window!)
            var notificationLabelConfiguration = NotificationLabelConfiguration()
            notificationCenterConfiguration.style = StatusBarNotificationCenter.Style.custom
            notificationCenterConfiguration.statusBarIsHidden = true
            notificationCenterConfiguration.height = 40
            //notificationLabelConfiguration.font = UIFont
            notificationLabelConfiguration.backgroundColor = UIColor.white
            notificationLabelConfiguration.textColor = UIColor.red
            notificationLabelConfiguration.multiline = true
            let nibContents = Bundle.main.loadNibNamed("NotiView", owner: self, options: nil)
            let view2 = nibContents?.first as! UIView
            StatusBarNotificationCenter.showStatusBarNotificationWithView(view2, forDuration: 1.5, withNotificationCenterConfiguration: notificationCenterConfiguration)
        }
    }

    @IBAction func goYesterday(_ sender: Any) {
        self.pickerView.selectItem(passedDaysCount(selectedDate: selectedPicker)-2, animated: false)
        
    }
    @IBAction func goTomorrow(_ sender: Any) {
        self.pickerView.selectItem(passedDaysCount(selectedDate: selectedPicker), animated: false)
    }
}


