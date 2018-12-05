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
    var offset: CGFloat = 20
    var textPosY: CGFloat!
    var mileTime: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.frame = CGRect(x: contentView.frame.origin.x, y: contentView.frame.origin.y, width: 414, height: 70)
        textPosY = contentView.frame.height/2 - 6
        setUpRankLabel()
        setUpUserPicture()
        setUpUserName()
        setUpMileTime()
    }
    
    func setUpRankLabel() {
        rank = UILabel(frame: CGRect(x: offset, y: textPosY, width: 18, height: 18))
        rank.font = UIFont.boldSystemFont(ofSize: 18)
        rank.textColor = .black
//        rank.sizeToFit()
        contentView.addSubview(rank)
    }
    
    func setUpUserPicture() {
        userPicture = UIImageView(frame: CGRect(x: rank.frame.maxX + 15, y: contentView.frame.height/2 - 22.5, width: 45, height: 45))
        userPicture.layer.cornerRadius = userPicture.frame.width / 2
        userPicture.layer.masksToBounds = true
        contentView.addSubview(userPicture)
    }
    
    func setUpUserName() {
        userName = UILabel(frame: CGRect(x: userPicture.frame.maxX + 15, y: textPosY, width: 16, height: 16))
        userName.font = UIFont.boldSystemFont(ofSize: 16)
        userName.textColor = UIColor.black
        contentView.addSubview(userName)
    }
    
    func setUpMileTime() {
        let textSize: CGFloat = 30
        mileTime = UILabel(frame: CGRect(x: contentView.frame.width - offset, y: contentView.frame.height/2 - textSize/2, width: textSize, height: textSize))
        mileTime.font = UIFont.boldSystemFont(ofSize: textSize)
        mileTime.textColor = UIColor.black
        contentView.addSubview(mileTime)
    }
    

}


// Extension to add image
extension UILabel {
    func addImage(imageName: String) {
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        attachment.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        let myString:NSMutableAttributedString = NSMutableAttributedString(string: self.text ?? "")
        myString.append(attachmentString)
        
        self.attributedText = myString
    }
}
