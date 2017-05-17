//
//  ChartsViewController.swift
//  test
//
//  Created by Alpaca on 2017. 3. 10..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit
import Charts

class ChartsViewController: UIViewController {

    //@IBOutlet weak var lineChartView: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        //let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0]
        
        //setChart(dataPoints: months, values: unitsSold)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(x: <#T##Double#>, y: <#T##Double#>)
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "Units Sold")
        let lineChartData = LineChartData(dataSets: [lineChartDataSet])
        lineChartView.data = lineChartData
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
