//
//  SecondViewController.swift
//  RecordBook
//
//  Created by Erik Fisher on 11/26/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit
import Charts

class SecondViewController: UIViewController {
    
    var coloredBackground: UIView!
    var nameLabel: UILabel!
    var fontSize: CGFloat!
    var lightGrayColor: UIColor!
    var darkGrayColor: UIColor!
    var rankingView: UIView!
    var statsView: UIView!
    var boxOffset: CGFloat!
    var milesRunLabel: UILabel!
    var lineChartView: LineChartView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUpUI() {
        fontSize = 26
        lightGrayColor = UIColor(red: 224/255, green: 224/255, blue: 235/255, alpha: 1)
        darkGrayColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
        boxOffset = 20
        view.backgroundColor = lightGrayColor
        setUpColoredSection()
        setUpRankingSection()
        setUpStatsSection()
    }
    
    func setUpColoredSection() {
        // Set up background
        let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.38)
        let backgroundColor = UIColor(red: 51/255, green: 153/255, blue: 1, alpha: 1)
        coloredBackground = UIView(frame: rect)
        coloredBackground.backgroundColor = backgroundColor
        coloredBackground.dropShadow(color: backgroundColor, opacity: 1, offSet: CGSize(width: 0, height: 3), radius: 15, scale: true)
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
        followersLabel.textColor = lightGrayColor
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
        followingLabel.textColor = lightGrayColor
        followingLabel.sizeToFit()
        followingLabel.frame.origin.x = followingOffsetX  - followingLabel.frame.width / 2
        coloredBackground.addSubview(followingLabel)
        view.addSubview(coloredBackground)
    }
    
    func setUpRankingSection() {
        rankingView = UIView(frame: CGRect(x: boxOffset, y: coloredBackground.frame.maxY + 30, width: view.frame.width - boxOffset * 2, height: 130))
        rankingView.backgroundColor = UIColor.white
        rankingView.clipsToBounds = true
        rankingView.layer.cornerRadius = 5
        rankingView.dropShadow(color: UIColor.black, opacity: 0.05, offSet: CGSize(width: 0, height: 0), radius: 3, scale: true)
        // Add medal icon
        let medalIcon = UIImageView(frame: CGRect(x: rankingView.frame.minX + 10, y: 28, width: 80, height: 80))
        medalIcon.image = UIImage(named: "medal.png")
        rankingView.addSubview(medalIcon)
        // Create ranking UI
        let nationRank = UILabel(frame: CGRect(x: medalIcon.frame.maxX + 30, y: medalIcon.frame.minY - 5, width: 50, height: 50))
        nationRank.text = "#4"
        nationRank.font = UIFont.boldSystemFont(ofSize: fontSize + 20)
        nationRank.textColor = UIColor.black
        nationRank.sizeToFit()
        rankingView.addSubview(nationRank)
        let nationRankLabel = UILabel(frame: CGRect(x: nationRank.frame.maxX - nationRank.frame.width/2, y: nationRank.frame.maxY + 5, width: 50, height: 50))
        nationRankLabel.text = "NATIONAL RANK"
        nationRankLabel.font = nationRankLabel.font.withSize(fontSize - 13)
        nationRankLabel.textColor = darkGrayColor
        nationRankLabel.sizeToFit()
        nationRankLabel.frame.origin.x -= nationRankLabel.frame.width / 2
        rankingView.addSubview(nationRankLabel)
        let stateRank = UILabel(frame: CGRect(x: nationRank.frame.maxX + 70, y: medalIcon.frame.minY - 5, width: 50, height: 50))
        stateRank.text = "#1"
        stateRank.font = UIFont.boldSystemFont(ofSize: fontSize + 20)
        stateRank.textColor = UIColor.black
        stateRank.sizeToFit()
        rankingView.addSubview(stateRank)
        let stateRankLabel = UILabel(frame: CGRect(x: stateRank.frame.maxX - stateRank.frame.width/2, y: nationRank.frame.maxY + 5, width: 50, height: 50))
        stateRankLabel.text = "STATE RANK"
        stateRankLabel.font = stateRankLabel.font.withSize(fontSize - 13)
        stateRankLabel.textColor = darkGrayColor
        stateRankLabel.sizeToFit()
        stateRankLabel.frame.origin.x -= stateRankLabel.frame.width / 2
        rankingView.addSubview(stateRankLabel)
        view.addSubview(rankingView)
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
        statsTitle.textColor = darkGrayColor
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
        view.addSubview(statsView)
    }
    
    func setUpWeekChart() {
        lineChartView = LineChartView(frame: CGRect(x: 15, y: milesRunLabel.frame.maxY + 10, width: statsView.frame.width - 30, height: 150))
        statsView.addSubview(lineChartView)
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

