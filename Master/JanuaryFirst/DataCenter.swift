//
//  DataCenter.swift
//  test
//
//  Created by cscoi009 on 2017. 1. 31..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import Foundation
import UIKit

let dataCenter:DataCenter = DataCenter()
let Color = ColorSetting() // 색상 담아둔 클래스 인스턴스화
let fileName = "DayData.brch"

class DataCenter {
    var days:[Days] = []
    
    var filePath:String { get{
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory + "/" + fileName
        }}
    
    init() {
        if FileManager.default.fileExists(atPath: self.filePath) {
            //read
            if let unarchArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.filePath) as? [Days] {
                days += unarchArray
            }
        } else {
            self.days += defaultData()
        }
    }
    func save(){
        NSKeyedArchiver.archiveRootObject(self.days, toFile: self.filePath)
    }
}
    func defaultData() -> Array<Days> {
        let EmptyDays = Days()
        let EmptyDay = DayClass()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let ExampleDate = formatter.date(from: "2016 12 25")!
        EmptyDay.date = ExampleDate
        EmptyDays.dayArr.append(EmptyDay)
        let EmptyArr : [Days] = [EmptyDays]
        return EmptyArr
}

func makeDayClass() {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy MM dd"
    
    let startDate = formatter.date(from: "2016 12 25")!
    let endDate = formatter.date(from: "2018 12 31")!
    var checkDate = formatter.date(from: "2016 12 25")!
        
    while (startDate...endDate).contains(checkDate) {
        
        let newDay = DayClass()
        newDay.date = checkDate
        dataCenter.days[0].dayArr.append(newDay)
        checkDate = checkDate.addingTimeInterval(60*60*24)
    }
}



class Days : NSObject, NSCoding {
    var dayArr : [DayClass] = []
    override init(){
        self.dayArr = []
    }
    required init?(coder aDecoder : NSCoder) {
        self.dayArr = aDecoder.decodeObject(forKey : "dayArr") as! [DayClass]
    }
    func encode(with aCoder : NSCoder)  {
        aCoder.encode(self.dayArr,forKey : "dayArr")
    }
    
}
class DayClass : NSObject , NSCoding {
    var date : Date? = nil
    var diary1 = Diary()
    var diary2 = Diary()
    var diary3 = Diary()
    
    override init(){
        self.date = nil
    }

    
    required init?(coder aDecoder : NSCoder) {
        self.date = aDecoder.decodeObject(forKey : "date") as? Date
        self.diary1 = aDecoder.decodeObject(forKey : "diary1") as! Diary
        self.diary2 = aDecoder.decodeObject(forKey : "diary2") as! Diary
        self.diary3 = aDecoder.decodeObject(forKey : "diary3") as! Diary
    }
    func encode(with aCoder : NSCoder)  {
        aCoder.encode(self.date,forKey : "date")
        aCoder.encode(self.diary1,forKey : "diary1")
        aCoder.encode(self.diary2,forKey : "diary2")
        aCoder.encode(self.diary3,forKey : "diary3")
    }
}

class Diary : NSObject, NSCoding {
    var name:String?
    var content:String?
    var rate:Int?
    var colour : UIColor?
    
    override init(){
        self.name = ""
        self.rate = 0
        self.content = ""
        self.colour = Color.backGroundColor.withAlphaComponent(0.1)
    }
    required init?(coder aDecoder : NSCoder) {
        self.name = aDecoder.decodeObject(forKey : "name") as? String
        self.content = aDecoder.decodeObject(forKey : "content") as? String
        self.rate = aDecoder.decodeObject(forKey : "rate") as? Int
        self.colour = aDecoder.decodeObject(forKey : "colour") as? UIColor
        
        
    }
    func encode(with aCoder : NSCoder)  {
        aCoder.encode(self.name,forKey : "name")
        aCoder.encode(self.content,forKey : "content")
        aCoder.encode(self.rate,forKey : "rate")
        aCoder.encode(self.colour,forKey : "colour")
    }

    
}


class GoalSetting: NSObject, NSCoding {
    var goal1 : String?
    var goal2 : String?
    var goal3 : String?
    
    var goal1Colour: UIColor?
    var goal2Colour: UIColor?
    var goal3Colour: UIColor?
    
    var goal1ColourNum : Int?
    var goal2ColourNum : Int?
    var goal3ColourNum : Int?

    
    override init() {
        self.goal1 = ""
        self.goal2 = ""
        self.goal3 = ""
        self.goal1Colour = nil
        self.goal2Colour = nil
        self.goal3Colour = nil
        self.goal1ColourNum = 0
        self.goal2ColourNum = 0
        self.goal3ColourNum = 0
    }
    
    required init?(coder aDecoder : NSCoder) {
        self.goal1 = aDecoder.decodeObject(forKey : "goal1") as? String
        self.goal2 = aDecoder.decodeObject(forKey : "goal2") as? String
        self.goal3 = aDecoder.decodeObject(forKey : "goal3") as? String
        self.goal1Colour = aDecoder.decodeObject(forKey : "goal1Colour") as? UIColor
        self.goal2Colour = aDecoder.decodeObject(forKey : "goal2Colour") as? UIColor
        self.goal3Colour = aDecoder.decodeObject(forKey : "goal3Colour") as? UIColor
        self.goal1ColourNum = aDecoder.decodeObject(forKey : "goal1ColourNum") as? Int
        self.goal2ColourNum = aDecoder.decodeObject(forKey : "goal2ColourNum") as? Int
        self.goal3ColourNum = aDecoder.decodeObject(forKey : "goal3ColourNum") as? Int

    }
    func encode(with aCoder : NSCoder)  {
        aCoder.encode(self.goal1,forKey : "goal1")
        aCoder.encode(self.goal2,forKey : "goal2")
        aCoder.encode(self.goal3,forKey : "goal3")
        aCoder.encode(self.goal1Colour,forKey : "goal1Colour")
        aCoder.encode(self.goal2Colour,forKey : "goal2Colour")
        aCoder.encode(self.goal3Colour,forKey : "goal3Colour")
        aCoder.encode(self.goal1ColourNum,forKey : "goal1ColourNum")
        aCoder.encode(self.goal2ColourNum,forKey : "goal2ColourNum")
        aCoder.encode(self.goal3ColourNum,forKey : "goal3ColourNum")
    }
}


class ColorSetting { // 색 설정
    var backGroundColor : UIColor // 배경색
    var deepFontColor : UIColor       // 진한 글자색
    var dimFontColor : UIColor
    var deepLineColor : UIColor
    var dimLineColor : UIColor
    var goalColor1 : UIColor
    var goalColor2 : UIColor
    var goalColor3 : UIColor
    var goalColor4 : UIColor
    var goalColor5 : UIColor
    
    init() {
        backGroundColor = white
        deepFontColor = black
        dimFontColor = lightGray
        deepLineColor = black
        dimLineColor = lightGray
        goalColor1 = red
        goalColor2 = yellow
        goalColor3 = green
        goalColor4 = blue
        goalColor5 = purple
    }
    func setBlack() {
        backGroundColor = darkBlack
        deepFontColor = white
        dimFontColor = lightGray
        deepLineColor = white
        dimLineColor = lightGray
        goalColor1 = red
        goalColor2 = yellow
        goalColor3 = green
        goalColor4 = blue
        goalColor5 = purple
    }
    func setWhite() {
        backGroundColor = white
        deepFontColor = black
        dimFontColor = lightGray
        deepLineColor = black
        dimLineColor = lightGray
        goalColor1 = red
        goalColor2 = yellow
        goalColor3 = green
        goalColor4 = blue
        goalColor5 = purple
    }
}

// color 
let red = UIColor(colorWithHexValue: 0xEF5350)
let yellow = UIColor(colorWithHexValue: 0xFFEE58)
let green = UIColor(colorWithHexValue: 0x81C784)
let blue = UIColor(colorWithHexValue: 0x29B6F6)
let purple = UIColor(colorWithHexValue: 0xBA68C8)
let black = UIColor.black
let white = UIColor(colorWithHexValue: 0xFFFFFF)
let lightGray = UIColor(colorWithHexValue: 0x979797)
let darkBlack = UIColor(colorWithHexValue: 0x27282A)

func backgroundColor(themeNum : Int) -> UIColor {
    var backGroundColor : UIColor
    switch themeNum {
    case 1 : backGroundColor = darkBlack
    case 2 : backGroundColor = white
    default: backGroundColor = darkBlack
    }
    return backGroundColor;
}

