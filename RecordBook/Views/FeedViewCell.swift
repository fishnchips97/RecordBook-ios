//
//  FeedViewCell.swift
//  RecordBook
//
//  Created by Boris Yue on 11/29/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit

class FeedViewCell: UITableViewCell {
    
    var userPicture: UIImageView!
    var userName: UILabel!
    var dateTime: UILabel!
    var postPicture: UIImageView!
    var postText: UILabel!
    var likeIcon: UIImageView!
    var commentIcon: UIImageView!
    var shareIcon: UIImageView!
    var likeLabel: UILabel!
    var commentLabel: UILabel!
    var shareLabel: UILabel!
    let offset: CGFloat = 15
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.frame = CGRect(x: contentView.frame.origin.x, y: contentView.frame.origin.y, width: 414, height: Constants.cellHeight)
        setUpImage()
        setUpUserName()
        setUpDateTime()
        setUpPostText()
        setUpPostPicture()
        setUpMetaData() //likes, comments, shares
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpImage() {
        userPicture = UIImageView(frame: CGRect(x: offset, y: offset + 5, width: 50, height: 50))
        userPicture.layer.cornerRadius = userPicture.frame.width / 2
        userPicture.layer.masksToBounds = true
        contentView.addSubview(userPicture)
    }
    
    func setUpUserName() {
        userName = UILabel(frame: CGRect(x: userPicture.frame.maxX + 10, y: userPicture.frame.minY + 25, width: 50, height: 50))
        userName.font = UIFont.boldSystemFont(ofSize: 16)
        userName.textColor = UIColor.black
        contentView.addSubview(userName)
    }
    
    func setUpDateTime() {
        dateTime = UILabel(frame: CGRect(x: contentView.frame.width - offset, y: userName.frame.minY - 10, width: 50, height: 50))
        dateTime.font = UIFont.systemFont(ofSize: 16)
        dateTime.textColor = Constants.darkGrayColor
        contentView.addSubview(dateTime)
    }
    
    func setUpPostText() {
        postText = UILabel(frame: CGRect(x: offset, y: userPicture.frame.maxY + 5, width: contentView.frame.width - offset * 2, height: 40))
        postText.font = UIFont.systemFont(ofSize: 16)
        postText.textColor = UIColor.black
        postText.lineBreakMode = .byWordWrapping // allow mutliple lines
        postText.numberOfLines = 0
//        userName.frame.origin.y -= userName.frame.height / 2
        contentView.addSubview(postText)
    }
    
    func setUpPostPicture() {
        postPicture = UIImageView(frame: CGRect(x: 0, y: 15, width: contentView.frame.width, height: 210))
        contentView.addSubview(postPicture)
    }
    
    func setUpMetaData() {
        let verticalOffset: CGFloat = 15
        likeIcon = UIImageView(frame: CGRect(x: offset, y: verticalOffset, width: 16, height: 16))
        likeIcon.image = UIImage(named: "like")
        contentView.addSubview(likeIcon)
        
        likeLabel = UILabel(frame: CGRect(x: 10, y: verticalOffset, width: 50, height: 50))
        likeLabel.font = UIFont.systemFont(ofSize: 16)
        likeLabel.textColor = UIColor.black
        contentView.addSubview(likeLabel)
        
        commentIcon = UIImageView(frame: CGRect(x: offset + 20, y: verticalOffset, width: 16, height: 16))
        commentIcon.image = UIImage(named: "comment")
        contentView.addSubview(commentIcon)
        
        commentLabel = UILabel(frame: CGRect(x: 10, y: verticalOffset, width: 50, height: 50))
        commentLabel.font = UIFont.systemFont(ofSize: 16)
        commentLabel.textColor = UIColor.black
        contentView.addSubview(commentLabel)
        
        shareIcon = UIImageView(frame: CGRect(x: offset + 20, y: verticalOffset, width: 16, height: 16))
        shareIcon.image = UIImage(named: "share")
        contentView.addSubview(shareIcon)
        
        shareLabel = UILabel(frame: CGRect(x: 10, y: verticalOffset, width: 50, height: 50))
        shareLabel.font = UIFont.systemFont(ofSize: 16)
        shareLabel.textColor = UIColor.black
        contentView.addSubview(shareLabel)
        
    }

}
