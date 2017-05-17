//
//  ListViewController.swift
//  test
//
//  Created by LEOFALCON on 2017. 2. 1..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit


//typealias goal = (rate : Int, contents : String)
typealias Day = (date : Date, diary1 : Diary, diary2 : Diary, diary3 : Diary)
var dateForGetMonth = Date()
func makeArrForTable(month : Date) -> [Day] {
    var result : [Day] = []
    let monthArr = dataCenter.days[0].dayArr.filter({ day in
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM"
        
        let settingMonth = formatter.string(from: month)
        let arrMonth = formatter.string(from: day.date!)
        if settingMonth == arrMonth{
            return true
        }
        else {
            return false
        }
    })
    for index in monthArr.indices {
        var day : Day
        let arrDate = monthArr[index].date
        day = (arrDate!,monthArr[index].diary1, monthArr[index].diary2,monthArr[index].diary3)
        result.append(day)
    }
    return result
}
class ListViewCell : UITableViewCell {
    @IBOutlet var leftView: UIView!
    @IBOutlet var rightView: UIView!
    @IBOutlet var day: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var rateColor1: UIView!
    @IBOutlet var rateColor2: UIView!
    @IBOutlet var rateColor3: UIView!
    @IBOutlet var color1constraint: NSLayoutConstraint!
    @IBOutlet var color2constraint: NSLayoutConstraint!
    @IBOutlet var color3constraint: NSLayoutConstraint!
    @IBOutlet var color1constraintCenter: NSLayoutConstraint!
    @IBOutlet var color2constraintCenter: NSLayoutConstraint!
    @IBOutlet var color3constraintCenter: NSLayoutConstraint!
    @IBOutlet var goal1Contents: UILabel!
    @IBOutlet var goal2Contents: UILabel!
    @IBOutlet var goal3Contents: UILabel!
    @IBOutlet var goalView1: UIView!
    @IBOutlet var GoalView2: UIView!
    @IBOutlet var goalView3: UIView!
}


class ListViewController: UITableViewController {
    @IBOutlet var topView: UIView!
    @IBOutlet var month: UILabel!
    
    @IBOutlet var nextMonth: UIButton!
    @IBAction func nextMonth(_ sender: Any) {
        dateForGetMonth =  Calendar.current.date(byAdding: .month, value: 1, to: dateForGetMonth)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM"
        month.text = formatter.string(from: dateForGetMonth)
        monthArr = makeArrForTable(month: dateForGetMonth)
        self.tableView.reloadData()
        if month.text == "2018 11" {
            nextMonth.isHidden = true
        }
        if month.text != "2017 01" {
            previousMonth.isHidden = false
        }
    }
    @IBOutlet var previousMonth: UIButton!
    @IBAction func previousMonth(_ sender: Any) {
        dateForGetMonth =  Calendar.current.date(byAdding: .month, value: -1, to: dateForGetMonth)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM"
        month.text = formatter.string(from: dateForGetMonth)
        monthArr = makeArrForTable(month: dateForGetMonth)
        self.tableView.reloadData()
        if month.text == "2017 01" {
            previousMonth.isHidden = true
        }
        if month.text != "2018 11" {
            nextMonth.isHidden = false
        }
    }
    var monthArr = makeArrForTable(month: dateForGetMonth)
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.backGroundColor
        
        let formatter = DateFormatter()
        monthArr = makeArrForTable(month: dateForGetMonth)
        formatter.dateFormat = "yyyy MM"
        month.text = formatter.string(from: dateForGetMonth)
        month.textColor = Color.deepFontColor
        topView.backgroundColor = UIColor.clear
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return monthArr.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath)
    
        guard let Cell = cell as? ListViewCell else {
            return cell
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        
        
        let dayCell = monthArr[indexPath.row]
        let textcolor = Color.deepFontColor
        let dateText = formatter.string(from: dayCell.date)
        Cell.color1constraintCenter.isActive = false
        Cell.color2constraintCenter.isActive = false
        Cell.color3constraintCenter.isActive = false
        if dayCell.diary2.name == "" {
            Cell.GoalView2.isHidden = true
        }else{
            Cell.GoalView2.isHidden = false
        }
        if dayCell.diary3.name == "" {
            Cell.goalView3.isHidden = true
        }else{
            Cell.goalView3.isHidden = false
        }
        
        
        //테두리 설정
        Cell.leftView.layer.borderColor = Color.dimLineColor.cgColor
        Cell.leftView.layer.borderWidth = 0.6
        Cell.rightView.layer.borderColor = Color.dimLineColor.cgColor
        Cell.rightView.layer.borderWidth = 0.6
        Cell.rightView.layer.addBorder(edge: .left, color: Color.dimLineColor, thickness: 0)
        
        Cell.date.text = dateText
        Cell.date.textColor = textcolor
        Cell.day.textColor = Color.dimFontColor
        Cell.day.text = getDayOfWeek(dayCell.date)
 
        Cell.goal1Contents.textColor = textcolor
        Cell.goal2Contents.textColor = textcolor
        Cell.goal3Contents.textColor = textcolor // color Setting
        
        Cell.goal1Contents.text = dayCell.diary1.content
        Cell.goal2Contents.text = dayCell.diary2.content
        Cell.goal3Contents.text = dayCell.diary3.content
        
        Cell.rateColor1.backgroundColor = dayCell.diary1.colour?.withAlphaComponent(CGFloat(Double((dayCell.diary1.rate!)) * 0.009 + 0.1))
        Cell.rateColor2.backgroundColor = dayCell.diary2.colour?.withAlphaComponent(CGFloat(Double((dayCell.diary2.rate!)) * 0.009 + 0.1))
        Cell.rateColor3.backgroundColor = dayCell.diary3.colour?.withAlphaComponent(CGFloat(Double((dayCell.diary3.rate!)) * 0.009 + 0.1))

        Cell.rateColor1.layer.cornerRadius = 5
        Cell.rateColor2.layer.cornerRadius = 5
        Cell.rateColor3.layer.cornerRadius = 5
        
        Cell.backgroundColor = Color.backGroundColor
        
        self.tableView.separatorStyle = .none
        
        if Cell.goal1Contents.text == "" {
            Cell.color1constraint.isActive = false
            Cell.color1constraintCenter.isActive = true
        } else {
            Cell.color1constraint.isActive = true
            Cell.color1constraintCenter.isActive = false
        }
        if Cell.goal2Contents.text == "" {
            Cell.color2constraint.isActive = false
            Cell.color2constraintCenter.isActive = true
        } else {
            Cell.color2constraint.isActive = true
            Cell.color2constraintCenter.isActive = false
        }
        if Cell.goal3Contents.text == "" {
            Cell.color3constraint.isActive = false
            Cell.color3constraintCenter.isActive = true
        } else {
            Cell.color3constraint.isActive = true
            Cell.color3constraintCenter.isActive = false
        }

        
        return Cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ModalViewController
        let myIndexPath = self.tableView.indexPathForSelectedRow
        let row = myIndexPath?.row
        let result = dataCenter.days[0].dayArr.index{$0.date == monthArr[row!].date}
        
            destinationVC.modalTransitionStyle = UIModalTransitionStyle.coverVertical
            
            destinationVC.diary1 = dataCenter.days[0].dayArr[result!].diary1 // 옵셔널 처리 필요함
            destinationVC.diary2 = dataCenter.days[0].dayArr[result!].diary2
            destinationVC.diary3 = dataCenter.days[0].dayArr[result!].diary3
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy" // or whatever format you want.
            
            destinationVC.varDate = dateFormatter.string(from: monthArr[row!].date)
        
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "M월"
        
            destinationVC.varMonth = monthChangeToEnglish(monthName: dateFormatter2.string(from: monthArr[row!].date))
            destinationVC.arrNum = result
            
            selectedDateInMonthView = monthArr[row!].date
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if month.text == "2017 02" {
                previousMonth.isHidden = true
                    dateForGetMonth =  Calendar.current.date(byAdding: .month, value: -1, to: dateForGetMonth)!
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy MM"
                month.text = formatter.string(from: dateForGetMonth)
                monthArr = makeArrForTable(month: dateForGetMonth)
                self.tableView.reloadData()
                } else if  month.text != "2017 01" {
                    dateForGetMonth =  Calendar.current.date(byAdding: .month, value: -1, to: dateForGetMonth)!
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy MM"
                    month.text = formatter.string(from: dateForGetMonth)
                    monthArr = makeArrForTable(month: dateForGetMonth)
                    self.tableView.reloadData()
                }
            case UISwipeGestureRecognizerDirection.down:
                break
            case UISwipeGestureRecognizerDirection.left:
                if month.text != "2018 11" {
                    dateForGetMonth =  Calendar.current.date(byAdding: .month, value: 1, to: dateForGetMonth)!
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy MM"
                month.text = formatter.string(from: dateForGetMonth)
                monthArr = makeArrForTable(month: dateForGetMonth)
                self.tableView.reloadData()
                previousMonth.isHidden = false
                }
            case UISwipeGestureRecognizerDirection.up:
                break
            default:
                break
            }
        }
    }
}




