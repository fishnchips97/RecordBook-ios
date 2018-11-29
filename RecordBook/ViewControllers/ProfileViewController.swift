//
//  SecondViewController.swift
//  RecordBook
//
//  Created by Erik Fisher on 11/26/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit
import Charts

class SecondViewController: UIViewController, UIScrollViewDelegate {
    
    var scrollView: UIScrollView!
    var containerView: UIView!
    var coloredBackground: UIView!
    var nameLabel: UILabel!
    var fontSize: CGFloat!
    var rankingView: UIView!
    var statsView: UIView!
    var boxOffset: CGFloat!
    var milesRunLabel: UILabel!
    var lineChartView: LineChartView!
    var gearView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScrollView()
        setUpUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.lineChartView.animate(xAxisDuration: 0, yAxisDuration: 1.0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = view.bounds
        containerView.frame = CGRect(x: 0, y: -50, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
        containerView.isUserInteractionEnabled = true

    }
    
    func setUpScrollView() {
        self.scrollView = UIScrollView()
        self.scrollView.delegate = self
        self.scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height + 30)
        containerView = UIView()
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
    }
    
    func setUpUI() {
        fontSize = 26
        boxOffset = 20
        view.backgroundColor = Constants.lightGrayColor
        setUpColoredSection()
        setUpRankingSection()
        setUpStatsSection()
        setUpGear()
    }
    
    func setUpColoredSection() {
        // Set up background
        let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.38)
        coloredBackground = UIView(frame: rect)
        coloredBackground.backgroundColor = Constants.lightBlueColor
        coloredBackground.dropShadow(color: Constants.lightBlueColor, opacity: 1, offSet: CGSize(width: 0, height: 3), radius: 15, scale: true)
        // Set up title
        let profileTitle = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.06, width: 100, height: 30))
        profileTitle.text = "Profile"
        profileTitle.font = profileTitle.font.withSize(fontSize)
//        profileTitle.font = UIFont.boldSystemFont(ofSize: 30)
        profileTitle.textColor = UIColor.white
        profileTitle.sizeToFit()
        profileTitle.frame.origin.x = coloredBackground.frame.width / 2 - profileTitle.frame.width / 2
        coloredBackground.addSubview(profileTitle)
        // Set up image
        let imageSize: CGFloat = 90
        let profileImage = UIImageView(frame: CGRect(x: view.frame.width / 2 - imageSize/2, y: profileTitle.frame.maxY + 35, width: imageSize, height: imageSize))
        profileImage.image = UIImage(named: "boris")
        profileImage.layer.borderWidth = 3.5
        profileImage.layer.masksToBounds = false
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.layer.borderColor = UIColor(red: 128/255, green: 191/255, blue: 1, alpha: 1).cgColor
        profileImage.clipsToBounds = true
        coloredBackground.addSubview(profileImage)
        // Set up name label
        nameLabel = UILabel(frame: CGRect(x: 0, y: profileImage.frame.maxY + 10, width: 100, height: 30))
        nameLabel.text = "Boris Yue"
        nameLabel.font = nameLabel.font.withSize(fontSize)
//        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        nameLabel.textColor = UIColor.white
        nameLabel.sizeToFit()
        nameLabel.frame.origin.x = coloredBackground.frame.width / 2 - nameLabel.frame.width / 2
        coloredBackground.addSubview(nameLabel)
        // Set up follows (followers, following)
        setUpFollows()
    }
    
    func setUpFollows() {
        // Add vertical line in between
        let lineView = UIView(frame: CGRect(x: view.frame.width / 2 - 1, y: nameLabel.frame.maxY + 27, width: 1, height: 30))
        lineView.layer.borderWidth = 4
        lineView.layer.borderColor = UIColor.white.cgColor
        coloredBackground.addSubview(lineView)
        let followersOffsetX = lineView.frame.minX - view.frame.width/4.5
        let followingOffsetX = lineView.frame.minX + view.frame.width/4.5
        let numFollowers = UILabel(frame: CGRect(x: 0, y: nameLabel.frame.maxY + 15, width: 100, height: 30))
        numFollowers.text = "8"
        //        numFollowers.font = numFollowers.font.withSize(fontSize)
        numFollowers.font = UIFont.boldSystemFont(ofSize: fontSize)
        numFollowers.textColor = UIColor.white
        numFollowers.sizeToFit()
        numFollowers.frame.origin.x = followersOffsetX -  numFollowers.frame.width / 2
        coloredBackground.addSubview(numFollowers)
        let followersLabel = UILabel(frame: CGRect(x: 0, y: numFollowers.frame.maxY + 3, width: 100, height: 30))
        followersLabel.text = "Followers"
        followersLabel.font = followersLabel.font.withSize(fontSize - 11)
        followersLabel.textColor = Constants.lightGrayColor
        followersLabel.sizeToFit()
        followersLabel.frame.origin.x = followersOffsetX -  followersLabel.frame.width / 2
        coloredBackground.addSubview(followersLabel)
        let numFollowing = UILabel(frame: CGRect(x: 0, y: nameLabel.frame.maxY + 15, width: 100, height: 30))
        numFollowing.text = "6"
        //        numFollowers.font = numFollowers.font.withSize(fontSize)
        numFollowing.font = UIFont.boldSystemFont(ofSize: fontSize)
        numFollowing.textColor = UIColor.white
        numFollowing.sizeToFit()
        numFollowing.frame.origin.x = followingOffsetX -  numFollowing.frame.width / 2
        coloredBackground.addSubview(numFollowing)
        let followingLabel = UILabel(frame: CGRect(x: 0, y: numFollowers.frame.maxY + 3, width: 100, height: 30))
        followingLabel.text = "Following"
        followingLabel.font = followersLabel.font.withSize(fontSize - 11)
        followingLabel.textColor = Constants.lightGrayColor
        followingLabel.sizeToFit()
        followingLabel.frame.origin.x = followingOffsetX  - followingLabel.frame.width / 2
        coloredBackground.addSubview(followingLabel)
        containerView.addSubview(coloredBackground)
    }
    
    func setUpRankingSection() {
        rankingView = UIView(frame: CGRect(x: boxOffset, y: coloredBackground.frame.maxY + 30, width: view.frame.width - boxOffset * 2, height: 130))
        rankingView.backgroundColor = UIColor.white
        rankingView.clipsToBounds = true
        rankingView.layer.cornerRadius = 5
        rankingView.dropShadow(color: UIColor.black, opacity: 0.05, offSet: CGSize(width: 0, height: 0), radius: 3, scale: true)
        // Add medal icon
        let medalIcon = UIImageView(frame: CGRect(x: 0, y: 10, width: 125, height: 125))
        medalIcon.image = UIImage(named: "medal.png")
        rankingView.addSubview(medalIcon)
        // Create ranking UI
        let nationRank = UILabel(frame: CGRect(x: medalIcon.frame.maxX + 10, y: 27, width: 50, height: 50))
        nationRank.text = "#4"
        nationRank.font = UIFont.boldSystemFont(ofSize: fontSize + 20)
        nationRank.textColor = UIColor.black
        nationRank.sizeToFit()
        rankingView.addSubview(nationRank)
        let nationRankLabel = UILabel(frame: CGRect(x: nationRank.frame.maxX - nationRank.frame.width/2, y: nationRank.frame.maxY, width: 50, height: 50))
        nationRankLabel.text = "NATIONAL RANK"
        nationRankLabel.font = nationRankLabel.font.withSize(fontSize - 13)
        nationRankLabel.textColor = Constants.darkGrayColor
        nationRankLabel.sizeToFit()
        nationRankLabel.frame.origin.x -= nationRankLabel.frame.width / 2
        rankingView.addSubview(nationRankLabel)
        let stateRank = UILabel(frame: CGRect(x: nationRank.frame.maxX + 70, y: 27, width: 50, height: 50))
        stateRank.text = "#1"
        stateRank.font = UIFont.boldSystemFont(ofSize: fontSize + 20)
        stateRank.textColor = UIColor.black
        stateRank.sizeToFit()
        rankingView.addSubview(stateRank)
        let stateRankLabel = UILabel(frame: CGRect(x: stateRank.frame.maxX - stateRank.frame.width/2, y: nationRank.frame.maxY, width: 50, height: 50))
        stateRankLabel.text = "STATE RANK"
        stateRankLabel.font = stateRankLabel.font.withSize(fontSize - 13)
        stateRankLabel.textColor = Constants.darkGrayColor
        stateRankLabel.sizeToFit()
        stateRankLabel.frame.origin.x -= stateRankLabel.frame.width / 2
        rankingView.addSubview(stateRankLabel)
        containerView.addSubview(rankingView)
    }
    
    func setUpStatsSection() {
        statsView = UIView(frame: CGRect(x: boxOffset, y: rankingView.frame.maxY + 30, width: view.frame.width - boxOffset * 2, height: 250))
        statsView.backgroundColor = UIColor.white
        statsView.clipsToBounds = true
        statsView.layer.cornerRadius = 5
        statsView.dropShadow(color: UIColor.black, opacity: 0.05, offSet: CGSize(width: 0, height: 0), radius: 3, scale: true)
        // Set up section title
        let statsTitle = UILabel(frame: CGRect(x: 15, y: 12, width: 50, height: 50))
        statsTitle.text = "THIS WEEK"
        statsTitle.font = statsTitle.font.withSize(fontSize - 13)
        statsTitle.textColor = Constants.darkGrayColor
        statsTitle.sizeToFit()
        statsView.addSubview(statsTitle)
        // Set up miles run this week
        milesRunLabel = UILabel(frame: CGRect(x: 15, y: statsTitle.frame.maxY + 5, width: 100, height: 30))
        milesRunLabel.text = "10 miles"
        milesRunLabel.font = milesRunLabel.font.withSize(fontSize)
        milesRunLabel.textColor = UIColor.black
        milesRunLabel.sizeToFit()
        statsView.addSubview(milesRunLabel)
        setUpWeekChart()
        containerView.addSubview(statsView)
    }
    
    func setUpWeekChart() {
        lineChartView = LineChartView(frame: CGRect(x: 15, y: milesRunLabel.frame.maxY + 10, width: statsView.frame.width - 30, height: 150))
        var dates: [String] = []
        // Create xAxis with past weeks worth of dates
        for i in (0...7).reversed() {
            let date = Calendar.current.date(byAdding: .day, value: -i, to: Date())!
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "MM/dd"
            let dateString = dateFormatter.string(from: date)
            dates.append(dateString)
        }
        let dataPoints: [Double] = [1,3,1,0,4,0,1] //yAxis
        let maxPoint = dataPoints.max()
        lineChartView.setLineChartData(xValues: dates, yValues: dataPoints, label: "Miles Ran")
        lineChartView.leftAxis.granularityEnabled = true
        lineChartView.leftAxis.granularity = 1.0
        lineChartView.leftAxis.axisMinimum = 0.0
        lineChartView.leftAxis.axisMaximum = Double(maxPoint! + 1)
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true
        statsView.addSubview(lineChartView)
    }
    
    func setUpGear() {
        gearView = UIView(frame: CGRect(x: boxOffset, y: statsView.frame.maxY + 30, width: view.frame.width - boxOffset * 2, height: 130))
        gearView.backgroundColor = UIColor.white
        gearView.clipsToBounds = true
        gearView.layer.cornerRadius = 5
        gearView.dropShadow(color: UIColor.black, opacity: 0.05, offSet: CGSize(width: 0, height: 0), radius: 3, scale: true)
        // Set up gear title
        let gearTitle = UILabel(frame: CGRect(x: 15, y: 12, width: 50, height: 50))
        gearTitle.text = "RUNNING GEAR"
        gearTitle.font = gearTitle.font.withSize(fontSize - 13)
        gearTitle.textColor = Constants.darkGrayColor
        gearTitle.sizeToFit()
        gearView.addSubview(gearTitle)
        // Set up logo
        let brand = UIImageView(frame: CGRect(x: view.frame.width/2 - 110, y: gearTitle.frame.maxY - 40, width: 170, height: 160))
        brand.image = UIImage(named: "shoe")
        gearView.addSubview(brand)
        
        containerView.addSubview(gearView)
    }

}

extension UIView {
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

// Extension to let xAxis accept strings
extension LineChartView {
    
    private class LineChartFormatter: NSObject, IAxisValueFormatter {
        
        var labels: [String] = []
        
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return labels[Int(value)]
        }
        
        init(labels: [String]) {
            super.init()
            self.labels = labels
        }
    }
    
    func setLineChartData(xValues: [String], yValues: [Double], label: String) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<yValues.count {
            let dataEntry = ChartDataEntry(x: Double(i), y: yValues[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(values: dataEntries, label: label)
        chartDataSet.drawValuesEnabled = false
        chartDataSet.lineWidth = 2
        chartDataSet.colors = [NSUIColor(cgColor: Constants.lightBlueColor.cgColor)]
        chartDataSet.circleRadius = 4
        chartDataSet.circleHoleRadius = 2.5
        chartDataSet.setCircleColor(NSUIColor(cgColor: Constants.yellowColor.cgColor))
        let chartData = LineChartData(dataSet: chartDataSet)
        
        let chartFormatter = LineChartFormatter(labels: xValues)
        let xAxis = XAxis()
        xAxis.valueFormatter = chartFormatter
        self.xAxis.valueFormatter = xAxis.valueFormatter
        
        self.data = chartData
    }
}

