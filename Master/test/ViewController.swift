//
//  ViewController.swift
//  test
//
//  Created by LEOFALCON on 2017. 1. 24..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit
import JTAppleCalendar
import AKPickerView_Swift
import UIKit

var selectedDateInMonthView = Date()
var flagForScroll = 0

class ViewController: UIViewController {


    @IBOutlet var month: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet  var calendarView: JTAppleCalendarView!
    var calendar = Calendar.current
    @IBAction func showToday(_ sender: Any) {
        scrollToToday()
    }
    @IBOutlet var showToday: UIButton!
    @IBOutlet var sunday: UILabel!
    @IBOutlet var monday: UILabel!
    @IBOutlet var tuesday: UILabel!
    @IBOutlet var wednesday: UILabel!
    @IBOutlet var thursday: UILabel!
    @IBOutlet var friday: UILabel!
    @IBOutlet var saturday: UILabel!
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        dataCenter.save()
        super.viewDidLoad()
        if userGoal.goal1 == "" {
            if let gvc = self.storyboard?.instantiateViewController(withIdentifier: "FirstGoalVC") as? FirstGoalSettingViewController {
                self.present(gvc, animated: false)
            }
        }
        self.view.backgroundColor = Color.backGroundColor
        month.textColor = Color.deepFontColor
        year.textColor = Color.deepFontColor
        showToday.tintColor = Color.deepFontColor
        sunday.textColor = Color.dimFontColor
        monday.textColor = Color.dimFontColor
        tuesday.textColor = Color.dimFontColor
        wednesday.textColor = Color.dimFontColor
        thursday.textColor = Color.dimFontColor
        friday.textColor = Color.dimFontColor
        saturday.textColor = Color.dimFontColor
        calendarView.backgroundColor = UIColor.clear
        calendar.timeZone = TimeZone.current
        calendarView.dataSource = self
        calendarView.delegate = self
        
        calendarView.registerCellViewXib(file: "CellView") // Registering your cell is manditory
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapCollectionView(gesture:)))
        doubleTapGesture.numberOfTapsRequired = 1 // add double tap
        calendarView.addGestureRecognizer(doubleTapGesture)

        calendarView.visibleDates { (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        flagForScroll = scrollOnce(flag: flagForScroll)
        calendarView.reloadData()

    }
    func scrollOnce(flag : Int) -> Int{
        if flag == 1 {
            scrollToToday()
            return 2
        }else{
            return 2
        }
    }

    

    func scrollToToday () {
        self.calendarView.scrollToDate(NSDate() as Date)
        let month2 = calendar.dateComponents([.month], from: Date()).month!
        let monthName = DateFormatter().monthSymbols[(month2-1) % 12]
        let year2 = calendar.component(.year, from: Date())

        year.text = String(year2)
        let location : String? = Locale.current.languageCode!
        if location! == "ko" {
            month.text = monthChangeToEnglish(monthName: monthName)
        }else{
            month.text = monthName
        }
    }

    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first else {
            return
        }
        //calendarView.scrollToDate(Date())
        let month2 = calendar.dateComponents([.month], from: startDate).month!
        let monthName = DateFormatter().monthSymbols[(month2-1) % 12]
        // 0 indexed array
        let year2 = calendar.component(.year, from: startDate)
        year.text = String(year2)
        let location : String = Locale.current.languageCode!
        if location == "ko"{
            month.text = monthChangeToEnglish(monthName: monthName)
        }else{
            month.text = monthName
        }

    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func didDoubleTapCollectionView(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view!)
        let cellState = calendarView.cellStatus(at: point)
        if cellState?.dateBelongsTo == .thisMonth {
            let result = getDate(days: dataCenter.days, date: (cellState?.date)!)

            if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "ModalVC") as? ModalViewController {
                uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical

                uvc.diary1 = dataCenter.days[0].dayArr[result].diary1 // 옵셔널 처리 필요함
                uvc.diary2 = dataCenter.days[0].dayArr[result].diary2
                uvc.diary3 = dataCenter.days[0].dayArr[result].diary3

                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy" // or whatever format you want.

                let month2 = calendar.dateComponents([.month], from: cellState!.date).month!
                let monthName = DateFormatter().monthSymbols[(month2-1) % 12]
                let year2 = calendar.component(.year, from: cellState!.date)

                let location : String? = Locale.current.languageCode!
                if location! == "ko" {
                    uvc.varMonth = monthChangeToEnglish(monthName: monthName)
                }else{
                    uvc.varMonth = monthName
                }
                uvc.varDate = String(year2)
                uvc.arrNum = result

                selectedDateInMonthView = cellState!.date
                self.present(uvc, animated: true)
            }
        }
    }

    // Function to handle in & out boundf
    func handleInOutBound(view: JTAppleDayCellView?, cellState: CellState) {

        guard let myCustomCell = view as? CellView  else {
            return
        }
            if cellState.dateBelongsTo == .thisMonth {
                myCustomCell.goal1.isHidden = false
                myCustomCell.goal2.isHidden = false
                myCustomCell.goal3.isHidden = false
                myCustomCell.isHidden = false

            } else {
                myCustomCell.goal1.isHidden = true
                myCustomCell.goal2.isHidden = true
                myCustomCell.goal3.isHidden = true
                myCustomCell.isHidden = true
        }
    }



    func defaultGoalAndColourSetting(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }

        let result = getDate(days: dataCenter.days, date: (cellState.date))

        if  .orderedSame == calendar.compare(dataCenter.days[0].dayArr[result].date!, to: cellState.date, toGranularity: .day) {
            myCustomCell.goal1.layer.cornerRadius = 4
            myCustomCell.goal2.layer.cornerRadius = 4
            myCustomCell.goal3.layer.cornerRadius = 4

            let colourAndRate1 = dataCenter.days[0].dayArr[result].diary1.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result].diary1.rate)!) * 0.009 + 0.1))
            let colourAndRate2 = dataCenter.days[0].dayArr[result].diary2.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result].diary2.rate)!) * 0.009 + 0.1))
            let colourAndRate3 = dataCenter.days[0].dayArr[result].diary3.colour?.withAlphaComponent(CGFloat(Double((dataCenter.days[0].dayArr[result].diary3.rate)!) * 0.009 + 0.1))
            // 색깔 상태랑 rate의 상태를 합침 (그라데이션을 만들기 위해서)

            myCustomCell.goal1.backgroundColor = colourAndRate1
            myCustomCell.goal2.backgroundColor = colourAndRate2
            myCustomCell.goal3.backgroundColor = colourAndRate3
            // 그것을 대입함
        }

    }

    func showToday(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CellView  else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd" // or whatever format you want.

        let currentDateString = dateFormatter.string(from: Date()) // today
        let cellStateDateString = dateFormatter.string(from: cellState.date)

        if currentDateString == cellStateDateString {
            myCustomCell.selectedView.layer.borderColor = Color.deepLineColor.cgColor
            myCustomCell.selectedView.layer.borderWidth = 1.0
            myCustomCell.selectedView.layer.cornerRadius = 20
            myCustomCell.selectedView.isHidden = false
        } else {
            myCustomCell.selectedView.isHidden = true
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }



}

extension ViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"

        let startDate = formatter.date(from: "2017 01 01")! // You can use date generated from a formatter
        let endDate = formatter.date(from: "2018 10 31")!      // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .sunday)
        return parameters
    }

    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        defaultGoalAndColourSetting(view: cell, cellState: cellState)
        handleInOutBound(view: cell, cellState: cellState)
        showToday(view: cell, cellState: cellState)
        }


    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleInOutBound(view: cell, cellState: cellState)
        showToday(view: cell, cellState: cellState)
        defaultGoalAndColourSetting(view: cell, cellState: cellState)
    }

    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleInOutBound(view: cell, cellState: cellState)
        showToday(view: cell, cellState: cellState)
        defaultGoalAndColourSetting(view: cell, cellState: cellState)
    }
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }

    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView) {
        self.setupViewsOfCalendar(from: calendarView.visibleDates())
    }
    func getDate(days : [Days], date: Date) -> Int {
        var result = -1
        var i = 0
        var sameChecker : ComparisonResult
        while result == -1 {
            sameChecker = calendar.compare(days[0].dayArr[i].date!, to: date, toGranularity: .day)
            if sameChecker == .orderedSame {
                result = i
            }
            i += 1
        }
        return result
    }
}
