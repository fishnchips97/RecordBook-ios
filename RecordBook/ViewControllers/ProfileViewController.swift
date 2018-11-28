//
//  SecondViewController.swift
//  RecordBook
//
//  Created by Erik Fisher on 11/26/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var coloredBackground: UIView!
    var nameLabel: UILabel!
    var fontSize: CGFloat!
    var lightGrayColor: UIColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func setUpUI() {
        fontSize = 26
        lightGrayColor = UIColor(red: 224/255, green: 224/255, blue: 235/255, alpha: 1)
        view.backgroundColor = lightGrayColor
        setUpColoredSection()
        setUpRankingSection()
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

