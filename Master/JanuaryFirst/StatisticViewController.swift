//
//  StatisticViewController.swift
//  test
//
//  Created by Alpaca on 2017. 2. 24..
//  Copyright © 2017년 LEOFALCON. All rights reserved.
//

import UIKit
import ScrollableGraphView

class StatisticViewController: UIViewController {
    
    @IBOutlet weak var firstGoalGraphView: UIView!
    @IBOutlet weak var secondGoalGraphView: UIView!
    @IBOutlet weak var thirdGoalGraphView: UIView!
    
    var firstGoalGraph = ScrollableGraphView()
    var graphConstraints = [NSLayoutConstraint]()
    var label = UILabel()
    var labelConstraints = [NSLayoutConstraint]()
    // Data
    var numberOfDataItems = 28
    
    lazy var dummyData: [Double] = [94,38,58,10,38,10,50,48,59,30,10.5,48.5]
    lazy var labels: [String] = self.generateSequentialLabels(self.numberOfDataItems, text: "FEB")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstGoalGraph = ScrollableGraphView(frame: self.firstGoalGraphView.frame)
        firstGoalGraph = createDarkGraph(self.firstGoalGraphView.frame)
        
        firstGoalGraph.set(data: dummyData, withLabels: labels)
        self.view.addSubview(firstGoalGraph)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func createDarkGraph(_ frame: CGRect) -> ScrollableGraphView {
        let graphView = ScrollableGraphView(frame: frame)
        
        graphView.backgroundFillColor = UIColor.black
        
        graphView.lineWidth = 1
        graphView.lineColor = UIColor.white
        graphView.lineStyle = ScrollableGraphViewLineStyle.straight
        
        graphView.shouldFill = true
        graphView.fillType = ScrollableGraphViewFillType.gradient
        graphView.fillColor = UIColor.gray
        graphView.fillGradientType = ScrollableGraphViewGradientType.linear
        graphView.fillGradientStartColor = UIColor.lightGray
        graphView.fillGradientEndColor = UIColor.lightGray
        
        graphView.dataPointSpacing = 80
        graphView.dataPointSize = 2
        graphView.dataPointFillColor = UIColor.white
        
        graphView.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        graphView.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        graphView.referenceLineLabelColor = UIColor.white
        graphView.numberOfIntermediateReferenceLines = 5
        graphView.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        graphView.shouldAnimateOnStartup = true
        graphView.shouldAdaptRange = true
        graphView.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        graphView.animationDuration = 1.5
        graphView.rangeMax = 50
        graphView.shouldRangeAlwaysStartAtZero = true
        
        return graphView
    }
    func generateSequentialLabels(_ numberOfItems: Int, text: String) -> [String] {
        var labels = [String]()
        for i in 0 ..< numberOfItems {
            labels.append("\(text) \(i+1)")
        }
        return labels
    }
    private func setupConstraints() {
        
        self.firstGoalGraph.translatesAutoresizingMaskIntoConstraints = false
        graphConstraints.removeAll()
        
        let topConstraint = NSLayoutConstraint(item: self.firstGoalGraph, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: self.firstGoalGraph, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.firstGoalGraph, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        let leftConstraint = NSLayoutConstraint(item: self.firstGoalGraph, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0)
        
        //let heightConstraint = NSLayoutConstraint(item: self.graphView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
        
        graphConstraints.append(topConstraint)
        graphConstraints.append(bottomConstraint)
        graphConstraints.append(leftConstraint)
        graphConstraints.append(rightConstraint)
        
        //graphConstraints.append(heightConstraint)
        
        self.view.addConstraints(graphConstraints)
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
