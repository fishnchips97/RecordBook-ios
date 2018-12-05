//
//  TableViewCell.swift
//  RecordBook
//
//  Created by Boris Yue on 12/4/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit

class LeaderboardViewCell: UITableViewCell {
    
    var rank: UILabel!
    var userPicture: UIImageView!
    var userName: UILabel!
    var offset: CGFloat = 10
    var textPosY: CGFloat!
    var mileTime: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.frame = CGRect(x: contentView.frame.origin.x, y: contentView.frame.origin.y, width: 414, height: 60)
        textPosY = contentView.frame.height/2 - 8
        setUpRankLabel()
        setUpUserPicture()
        setUpUserName()
        setUpMileTime()
    }
    
    func setUpRankLabel() {
        rank = UILabel(frame: CGRect(x: offset, y: textPosY, width: 16, height: 16))
        rank.text = "1"
        rank.font = UIFont.systemFont(ofSize: 16)
        rank.textColor = .black
        rank.sizeToFit()
        contentView.addSubview(rank)
    }
    
    func setUpUserPicture() {
        userPicture = UIImageView(frame: CGRect(x: rank.frame.maxX + offset + 5, y: contentView.frame.height/2 - 17.5, width: 35, height: 35))
        userPicture.layer.cornerRadius = userPicture.frame.width / 2
        userPicture.layer.masksToBounds = true
        userPicture.image = UIImage(named: "boris")
        contentView.addSubview(userPicture)
    }
    
    func setUpUserName() {
        userName = UILabel(frame: CGRect(x: userPicture.frame.maxX + offset + 5, y: textPosY, width: 16, height: 16))
        userName.text = "Boris Yue"
        userName.font = UIFont.systemFont(ofSize: 16)
        userName.textColor = UIColor.black
        userName.sizeToFit()
        contentView.addSubview(userName)
    }
    
    func setUpMileTime() {
        let textSize: CGFloat = 23
        mileTime = UILabel(frame: CGRect(x: contentView.frame.width - offset, y: contentView.frame.height/2 - textSize/2, width: textSize, height: textSize))
        mileTime.text = "4:27"
        mileTime.font = UIFont.boldSystemFont(ofSize: textSize)
        mileTime.textColor = UIColor.black
        mileTime.sizeToFit()
        mileTime.frame.origin.x -= mileTime.frame.width
        contentView.addSubview(mileTime)
    }
    

}
