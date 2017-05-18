//
//  FirstGoalSettingViewController.swift
//  test
//
//  Created by LEOFALCON on 2017. 2. 7..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit

class FirstGoalSettingViewController: UIViewController, UITextFieldDelegate {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBOutlet var goalDescription1: UILabel!
    @IBOutlet var goalDescription2: UILabel!
    @IBOutlet var goalDescription3: UILabel!
    @IBOutlet var colorDescription1: UILabel!
    @IBOutlet var colorDescription2: UILabel!
    @IBOutlet var colorDescription3: UILabel!
    @IBOutlet var topDescription_First: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var goal1Setting: UITextField!
    @IBOutlet var goal2Setting: UITextField!
    @IBOutlet var goal3Setting: UITextField!
    @IBOutlet var goal1Colour1: UIView!
    @IBOutlet var goal1Colour2: UIView!
    @IBOutlet var goal1Colour3: UIView!
    @IBOutlet var goal1Colour4: UIView!
    @IBOutlet var goal1Colour5: UIView!
    var selectGoal1Colour : UIColor? = Color.backGroundColor
    
    
    @IBAction func goal1Colour1Button(_ sender: Any) {
        print("동작함")
        color1Sellect(selectNum: 1)
        selectGoal1Colour = goal1Colour1.backgroundColor
    }

    @IBAction func goal1Colour2Button(_ sender: Any) {
        color1Sellect(selectNum: 2)
        selectGoal1Colour = goal1Colour2.backgroundColor
    }
    @IBAction func goal1Colour3Button(_ sender: Any) {
        color1Sellect(selectNum: 3)
        selectGoal1Colour = goal1Colour3.backgroundColor
    }
    @IBAction func goal1Colour4Button(_ sender: Any) {
        color1Sellect(selectNum: 4)
        selectGoal1Colour = goal1Colour4.backgroundColor
    }
    @IBAction func goal1Colour5Button(_ sender: Any) {
        color1Sellect(selectNum: 5)
        selectGoal1Colour = goal1Colour5.backgroundColor
    }
    
    @IBOutlet var goal2Colour1: UIView!
    @IBOutlet var goal2Colour2: UIView!
    @IBOutlet var goal2Colour3: UIView!
    @IBOutlet var goal2Colour4: UIView!
    @IBOutlet var goal2Colour5: UIView!
    var selectGoal2Colour : UIColor? = Color.backGroundColor
    
    @IBAction func goal2Colour1Button(_ sender: Any) {
        color2Sellect(selectNum: 1)
        selectGoal2Colour = goal2Colour1.backgroundColor
    }
    @IBAction func goal2Colour2Button(_ sender: Any) {
        color2Sellect(selectNum: 2)
        selectGoal2Colour = goal2Colour2.backgroundColor
    }
    @IBAction func goal2Colour3Button(_ sender: Any) {
        color2Sellect(selectNum: 3)
        selectGoal2Colour = goal2Colour3.backgroundColor
    }
    @IBAction func goal2Colour4Button(_ sender: Any) {
        color2Sellect(selectNum: 4)
        selectGoal2Colour = goal2Colour4.backgroundColor
    }
    @IBAction func goal2Colour5Button(_ sender: Any) {
        color2Sellect(selectNum: 5)
        selectGoal2Colour = goal2Colour5.backgroundColor
    }
    
    @IBOutlet var goal3Colour1: UIView!
    @IBOutlet var goal3Colour2: UIView!
    @IBOutlet var goal3Colour3: UIView!
    @IBOutlet var goal3Colour4: UIView!
    @IBOutlet var goal3Colour5: UIView!
    var selectGoal3Colour : UIColor? = Color.backGroundColor

    
    @IBAction func goal3Colour1Button(_ sender: Any) {
        color3Sellect(selectNum: 1)
        selectGoal3Colour = goal3Colour1.backgroundColor
    }
    @IBAction func goal3Colour2Button(_ sender: Any) {
        color3Sellect(selectNum: 2)
        selectGoal3Colour = goal3Colour2.backgroundColor
    }
    @IBAction func goal3Colour3Button(_ sender: Any) {
        color3Sellect(selectNum: 3)
        selectGoal3Colour = goal3Colour3.backgroundColor
    }
    @IBAction func goal3Colour4Button(_ sender: Any) {
        color3Sellect(selectNum: 4)
        selectGoal3Colour = goal3Colour4.backgroundColor
    }
    @IBAction func goal3Colour5Button(_ sender: Any) {
        color3Sellect(selectNum: 5)
        selectGoal3Colour = goal3Colour5.backgroundColor
    }

    @IBOutlet var addgoal2: UIButton!
    @IBAction func AddGoal2(_ sender: Any) {
        AllGoal2.isHidden = false
        addgoal2.isHidden = true
        addgoal3.isHidden = false
    }
    
    @IBOutlet var addgoal3: UIButton!
    @IBAction func AddGoal3(_ sender: Any) {
        AllGoal3.isHidden = false
        addgoal3.isHidden = true

    }
    @IBAction func DeleteGoal2(_ sender: Any) {
        if AllGoal3.isHidden == false {
            //  goal3이 존재하면 goal2를 삭제하는 것이 아니라 goal3의값을 2로 복사한 뒤 3을 삭제
            AllGoal3.isHidden = true
            addgoal3.isHidden = false
            goal2Colour1.backgroundColor = goal3Colour1.backgroundColor
            goal2Colour2.backgroundColor = goal3Colour2.backgroundColor
            goal2Colour3.backgroundColor = goal3Colour3.backgroundColor
            goal2Colour4.backgroundColor = goal3Colour4.backgroundColor
            goal2Colour5.backgroundColor = goal3Colour5.backgroundColor
            
            selectGoal2Colour = selectGoal3Colour
            goal2Setting.text = goal3Setting.text //  goal3의 데이터를 2로 복사
            selectGoal3Colour = Color.backGroundColor
            goal3Setting.text = "" // goal3의 데이터는 삭제
            
            color3Sellect(selectNum: 10)
        }
        else{
            AllGoal2.isHidden = true
            addgoal2.isHidden = false
            addgoal3.isHidden = true
            goal2Setting.text = ""
            color2Sellect(selectNum: 10)
            selectGoal2Colour = Color.backGroundColor// 2 데이터 삭제
        }
    }
    @IBAction func DeleteGoal3(_ sender: Any) {
        AllGoal3.isHidden = true
        addgoal3.isHidden = false
        goal3Setting.text = ""
        color3Sellect(selectNum: 10)
        selectGoal3Colour = Color.backGroundColor // 3 데이터 삭제

    }
    @IBOutlet var AllGoal2: UIView! // goal2 뷰 전체
    @IBOutlet var AllGoal3: UIView! // goal3 뷰 전체

    override func viewDidLoad() {
        super.viewDidLoad()
        topDescription_First.textColor = Color.deepFontColor
        colorDescription1.textColor = Color.deepFontColor
        colorDescription2.textColor = Color.deepFontColor
        colorDescription3.textColor = Color.deepFontColor
        goalDescription1.textColor = Color.deepFontColor
        goalDescription2.textColor = Color.deepFontColor
        goalDescription3.textColor = Color.deepFontColor
        
        goalDescription1.text = NSLocalizedString("goal", comment: "goalDescription")
        goalDescription2.text = NSLocalizedString("goal", comment: "goalDescription")
        goalDescription3.text = NSLocalizedString("goal", comment: "goalDescription")

        colorDescription1.text = NSLocalizedString("colorSetting", comment: "colorDescription")
        colorDescription2.text = NSLocalizedString("colorSetting", comment: "colorDescription")
        colorDescription3.text = NSLocalizedString("colorSetting", comment: "colorDescription")

        self.view.backgroundColor = Color.backGroundColor
        topDescription_First.text = NSLocalizedString("topDescription_First", comment: "topDescription_First")
        AllGoal2.isHidden = true
        AllGoal3.isHidden = true
        addgoal3.isHidden = true
        
        goal1Setting.delegate = self
        goal2Setting.delegate = self
        goal3Setting.delegate = self
        
        color1Sellect(selectNum: 10)
        color2Sellect(selectNum: 10)
        color3Sellect(selectNum: 10)
        
        goal1Setting.layer.borderColor = Color.dimLineColor.cgColor
        goal1Setting.backgroundColor = UIColor.clear
        goal1Setting.layer.borderWidth = 0.8
        goal1Setting.layer.cornerRadius = 0
        goal1Setting.tintColor = Color.deepFontColor
        goal1Setting.textColor = Color.deepFontColor
        goal1Setting.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("firstGoalPlaceHolder", comment: "Firstgoalholder"), attributes: [NSForegroundColorAttributeName: Color.dimFontColor.withAlphaComponent(0.5)])
        
        goal2Setting.layer.borderColor = Color.dimLineColor.cgColor
        goal2Setting.backgroundColor = UIColor.clear
        goal2Setting.layer.borderWidth = 0.8
        goal2Setting.layer.cornerRadius = 0
        goal2Setting.tintColor = Color.deepFontColor
        goal2Setting.textColor = Color.deepFontColor
        goal2Setting.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("secondGoalPlaceHolder", comment: "Secondgoalholder"), attributes: [NSForegroundColorAttributeName: Color.dimFontColor.withAlphaComponent(0.5)])
        
        goal3Setting.layer.borderColor = Color.dimLineColor.cgColor
        goal3Setting.backgroundColor = UIColor.clear
        goal3Setting.layer.borderWidth = 0.8
        goal3Setting.layer.cornerRadius = 0
        goal3Setting.tintColor = Color.deepFontColor
        goal3Setting.textColor = Color.deepFontColor
        goal3Setting.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("thirdGoalPlaceHolder", comment: "Thirdgoalholder"), attributes: [NSForegroundColorAttributeName: Color.dimFontColor.withAlphaComponent(0.5)])
        
        // TextField 커서 컬러 바꿈.
        UITextField.appearance().tintColor = UIColor.white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
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
        view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == goal3Setting {
            scrollView.setContentOffset(CGPoint(x:0,y:100), animated: true)
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == goal3Setting {
            scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        }
    }

    @IBAction func SaveSetting(_ sender: Any) {
        if goal1Setting.text == "" { //  1이 비어 있으면 에러
            let empty1Error = UIAlertController(title: NSLocalizedString("error", comment: "error"), message: NSLocalizedString("empty_goal1", comment: "empty_goal1"), preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.default, handler: {(ACTION) in return})
            empty1Error.addAction(okAction)
            self.present(empty1Error, animated: true, completion: nil)
        }
        else if ((goal1Setting.text != "" && selectGoal1Colour == Color.backGroundColor) || (goal2Setting.text != "" && selectGoal2Colour == Color.backGroundColor) || (goal3Setting.text != "" && selectGoal3Colour == Color.backGroundColor)) {
            // > 목표 창이 채워 졌는데, 색 설정이 안되어 있을때 에러
            let emptyColour = UIAlertController(title: NSLocalizedString("error", comment: "error"), message: NSLocalizedString("empty_color", comment: "empty_color"), preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.default, handler: {(ACTION) in return})
            emptyColour.addAction(okAction)
            self.present(emptyColour, animated: true, completion: nil)
            
        }
        else if ((goal1Setting.text == "" && selectGoal1Colour != Color.backGroundColor) || (goal2Setting.text == "" && selectGoal2Colour != Color.backGroundColor) || (goal3Setting.text == "" && selectGoal3Colour != Color.backGroundColor)) {
            let emptyGoal = UIAlertController(title: NSLocalizedString("error", comment: "error"), message: NSLocalizedString("empty_goal", comment: "empty_goal"), preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.default, handler: {(ACTION) in return})
            emptyGoal.addAction(okAction)
            self.present(emptyGoal, animated: true, completion: nil)
        }
            
            
        else {

        
        
        userGoal.goal1 = goal1Setting.text
        userGoal.goal2 = goal2Setting.text
        userGoal.goal3 = goal3Setting.text
        
        userGoal.goal1Colour = selectGoal1Colour
        userGoal.goal2Colour = selectGoal2Colour
        userGoal.goal3Colour = selectGoal3Colour
        
        // 세 가지 목표 이름을 저장하는 배열을 만듦.
        let goalArr : [String?] = [userGoal.goal1,userGoal.goal2,userGoal.goal3 ]
        let encodedGoal = NSKeyedArchiver.archivedData(withRootObject: goalArr)
        UserDefaults.standard.set(encodedGoal, forKey: "goalArr")
        
        if let data = UserDefaults.standard.data(forKey: "goalArr"), let goalList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] {
            for index in dataCenter.days[0].dayArr.indices { // 저장된 배열을 dataCenter에 집어 넣음
                dataCenter.days[0].dayArr[index].diary1.name = goalList[0]
                dataCenter.days[0].dayArr[index].diary2.name = goalList[1]
                dataCenter.days[0].dayArr[index].diary3.name = goalList[2]
            }
            dataCenter.save()
        }
        // 세 가지 목표에 대한 컬러를 저장하는 배열을 만듦.
        let goalColourArr = [userGoal.goal1Colour, userGoal.goal2Colour, userGoal.goal3Colour]
        let encodedGoalColour = NSKeyedArchiver.archivedData(withRootObject: goalColourArr)
        UserDefaults.standard.set(encodedGoalColour, forKey: "goalColourArr")
        
        if let data = UserDefaults.standard.data(forKey: "goalColourArr"), let goalColourlist = NSKeyedUnarchiver.unarchiveObject(with: data) as? [UIColor] {
            for index in dataCenter.days[0].dayArr.indices { // 저장된 배열을 dataCenter에 집어 넣음
                dataCenter.days[0].dayArr[index].diary1.colour = goalColourlist[0]
                dataCenter.days[0].dayArr[index].diary2.colour = goalColourlist[1]
                dataCenter.days[0].dayArr[index].diary3.colour = goalColourlist[2]
            }
        }
        let goalColourArrNum = [userGoal.goal1ColourNum, userGoal.goal2ColourNum, userGoal.goal3ColourNum]
        let encodedGoalColourNum = NSKeyedArchiver.archivedData(withRootObject: goalColourArrNum)
        UserDefaults.standard.set(encodedGoalColourNum, forKey: "goalColourArrNum")

        dataCenter.save()
        self.presentingViewController?.dismiss(animated: false)
        flagForScroll = 1

        }
    }
    
    
    func color1Sellect(selectNum: Int)  {
        goal1Colour1.backgroundColor = Color.goalColor1.withAlphaComponent(0.2)
        goal1Colour2.backgroundColor = Color.goalColor2.withAlphaComponent(0.2)
        goal1Colour3.backgroundColor = Color.goalColor3.withAlphaComponent(0.2)
        goal1Colour4.backgroundColor = Color.goalColor4.withAlphaComponent(0.2)
        goal1Colour5.backgroundColor = Color.goalColor5.withAlphaComponent(0.2)
        userGoal.goal1ColourNum = selectNum
        switch selectNum {
        case 1:
            goal1Colour1.backgroundColor = Color.goalColor1
        case 2:
            goal1Colour2.backgroundColor = Color.goalColor2
        case 3:
            goal1Colour3.backgroundColor = Color.goalColor3
        case 4:
            goal1Colour4.backgroundColor = Color.goalColor4
        case 5:
            goal1Colour5.backgroundColor = Color.goalColor5
        default : break
        }
    }
    func color2Sellect(selectNum: Int)  {
        goal2Colour1.backgroundColor = Color.goalColor1.withAlphaComponent(0.2)
        goal2Colour2.backgroundColor = Color.goalColor2.withAlphaComponent(0.2)
        goal2Colour3.backgroundColor = Color.goalColor3.withAlphaComponent(0.2)
        goal2Colour4.backgroundColor = Color.goalColor4.withAlphaComponent(0.2)
        goal2Colour5.backgroundColor = Color.goalColor5.withAlphaComponent(0.2)
        userGoal.goal2ColourNum = selectNum
        switch selectNum {
        case 1:
            goal2Colour1.backgroundColor = Color.goalColor1
        case 2:
            goal2Colour2.backgroundColor = Color.goalColor2
        case 3:
            goal2Colour3.backgroundColor = Color.goalColor3
        case 4:
            goal2Colour4.backgroundColor = Color.goalColor4
        case 5:
            goal2Colour5.backgroundColor = Color.goalColor5
        default : break
        }
    }
    
    func color3Sellect(selectNum: Int)  {
        goal3Colour1.backgroundColor = Color.goalColor1.withAlphaComponent(0.2)
        goal3Colour2.backgroundColor = Color.goalColor2.withAlphaComponent(0.2)
        goal3Colour3.backgroundColor = Color.goalColor3.withAlphaComponent(0.2)
        goal3Colour4.backgroundColor = Color.goalColor4.withAlphaComponent(0.2)
        goal3Colour5.backgroundColor = Color.goalColor5.withAlphaComponent(0.2)
        userGoal.goal3ColourNum = selectNum
        switch selectNum {
        case 1:
            goal3Colour1.backgroundColor = Color.goalColor1
        case 2:
            goal3Colour2.backgroundColor = Color.goalColor2
        case 3:
            goal3Colour3.backgroundColor = Color.goalColor3
        case 4:
            goal3Colour4.backgroundColor = Color.goalColor4
        case 5:
            goal3Colour5.backgroundColor = Color.goalColor5
        default :
            break
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        goal1Setting.endEditing(true) // textBox는 textFiled 오브젝트 outlet 연동할때의 이름.
        goal2Setting.endEditing(true)
        goal3Setting.endEditing(true)
        
        
    }

}
