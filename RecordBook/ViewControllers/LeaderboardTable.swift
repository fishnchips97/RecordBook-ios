//
//  LeaderboardTableViewController.swift
//  RecordBook
//
//  Created by Boris Yue on 12/4/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit

class LeaderboardTable: UIViewController {

    var users = ["1. Boris - 5:20", "2. Marina - 5:30", "3. Amy - 5:32", "4. Aviral - 5:35", "5. Erik - 5:37"]
    var leaderboardView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
    }

    
    func setUpTable() {
//        leaderboardView = UITableView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.height), style: .grouped)
        leaderboardView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        leaderboardView.register(LeaderboardViewCell.self, forCellReuseIdentifier: "leaderboardCell")
        leaderboardView.delegate = self
        leaderboardView.dataSource = self
        leaderboardView.separatorStyle = .none
        view.addSubview(leaderboardView)
    }
    
    
    
}

extension LeaderboardTable: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell") as! LeaderboardViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview() //remove stuff from cell before initializing
        }
        cell.awakeFromNib() //initialize cell
        //        let currentPost = posts[posts.count - 1 - indexPath.row]
        //        // PICTURE
        //        cell.userPicture.image = currentPost.userPicture
        //        // USERNAME
        //        cell.userName.text = currentPost.userName
        //        cell.userName.sizeToFit()
        //        cell.userName.frame.origin.y -= cell.userName.frame.height / 2
        //        // DATETIME
        //        cell.dateTime.text = currentPost.dateTime
        //        cell.dateTime.sizeToFit()
        //        cell.dateTime.frame.origin.x -= cell.dateTime.frame.width
        //        // POST TEXT
        //        cell.postText.text = currentPost.postText
        //        // POST IMAGE
        //        cell.postPicture.image = currentPost.postPicture
        //        cell.postPicture.frame.origin.y += cell.postText.frame.maxY
        //        // LIKE ICON AND TEXT
        //        cell.likeIcon.frame.origin.y += cell.postPicture.frame.maxY
        //        cell.likeLabel.text = currentPost.numLikes
        //        cell.likeLabel.sizeToFit()
        //        cell.likeLabel.frame.origin.x += cell.likeIcon.frame.maxX
        //        cell.likeLabel.frame.origin.y = cell.likeIcon.frame.minY - 1
        //        // COMMENT ICON AND TEXT
        //        cell.commentIcon.frame.origin.x += cell.likeLabel.frame.maxX
        //        cell.commentIcon.frame.origin.y += cell.postPicture.frame.maxY
        //        cell.commentLabel.text = currentPost.numComments
        //        cell.commentLabel.sizeToFit()
        //        cell.commentLabel.frame.origin.x += cell.commentIcon.frame.maxX
        //        cell.commentLabel.frame.origin.y = cell.commentIcon.frame.minY - 1
        //        // SHARE ICON AND TEXT
        //        cell.shareIcon.frame.origin.x += cell.commentLabel.frame.maxX
        //        cell.shareIcon.frame.origin.y += cell.postPicture.frame.maxY
        //        cell.shareLabel.text = currentPost.numShares
        //        cell.shareLabel.sizeToFit()
        //        cell.shareLabel.frame.origin.x += cell.shareIcon.frame.maxX
        //        cell.shareLabel.frame.origin.y = cell.shareIcon.frame.minY - 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { //makes the cells smaller
        //        let whiteView : UIView = UIView(frame: CGRect(x: 0, y: 10, width: cell.contentView.frame.width, height: cell.contentView.frame.height - 10))
        //        whiteView.layer.backgroundColor = UIColor.white.cgColor
        //        whiteView.layer.shadowOffset = CGSize(width: 0, height: 0)
        //        whiteView.layer.shadowOpacity = 0.2
        //        whiteView.layer.shadowRadius = 3
        //        cell.contentView.addSubview(whiteView)
        //        cell.contentView.sendSubviewToBack(whiteView)
        // Add line separator between each cell
        let lineView = UIView(frame: CGRect(x: 20, y: cell.contentView.frame.maxY, width: cell.contentView.frame.width - 40, height: 1))
        lineView.layer.borderWidth = 3
        lineView.layer.borderColor = Constants.lightGrayColor.cgColor
        lineView.layer.opacity = 0.5
        cell.contentView.addSubview(lineView)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    //    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //        let view = UIView(frame: CGRect(x: boxOffset, y: (navigationController?.navigationBar.frame.maxY)! + boxOffset, width: self.view.frame.width - boxOffset * 2, height: addPostHeight + 10))
    //        view.backgroundColor = Constants.lightGrayColor
    //        return view
    //    }
    
    //    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    //        view.backgroundColor = Constants.lightGrayColor
    //        let whiteView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.addPostHeight))
    //        whiteView.layer.backgroundColor = UIColor.white.cgColor
    //        whiteView.layer.shadowOffset = CGSize(width: 0, height: 0)
    //        whiteView.layer.shadowOpacity = 0.2
    //        whiteView.layer.shadowRadius = 3
    //        let addPostTextInput = UITextField(frame: CGRect(x: boxOffset+5, y: boxOffset+5, width: whiteView.frame.width - boxOffset * 2, height: whiteView.frame.height * 0.6))
    //        addPostTextInput.delegate = self
    //        addPostTextInput.font = UIFont.systemFont(ofSize: 16)
    //        addPostTextInput.textColor = Constants.darkGrayColor
    //        addPostTextInput.placeholder = "Type your status update..."
    //        addPostTextInput.contentVerticalAlignment = .top
    //        addPostTextInput.clearsOnBeginEditing = true
    //        addPostTextInput.textColor = UIColor.black
    //        addPostTextInput.tintColor = Constants.darkGrayColor
    //        addPostTextInput.returnKeyType = .go
    //        whiteView.addSubview(addPostTextInput)
    //        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    //        self.view.addGestureRecognizer(tap)
    //
    //        // Add horizontal line in between
    //        let lineView = UIView(frame: CGRect(x: 0, y: addPostTextInput.frame.maxY, width: whiteView.frame.width, height: 1))
    //        lineView.layer.borderWidth = 3
    //        lineView.layer.borderColor = Constants.lightGrayColor.cgColor
    //        lineView.layer.opacity = 0.8
    //        whiteView.addSubview(lineView)
    //
    //        // Add attachment options
    //        let pictureIcon = UIImageView(frame: CGRect(x: self.view.frame.width * 0.1 - 8, y: lineView.frame.maxY + 8, width: 16, height: 16))
    //        pictureIcon.image = UIImage(named: "picture")
    //        whiteView.addSubview(pictureIcon)
    //        let pictureText = UILabel(frame: CGRect(x: pictureIcon.frame.maxX + 5, y: lineView.frame.maxY + 7, width: 100, height: 30))
    //        pictureText.text = "Photo"
    //        pictureText.font = UIFont.systemFont(ofSize: 16)
    //        pictureText.textColor = UIColor.black
    //        pictureText.sizeToFit()
    //        whiteView.addSubview(pictureText)
    //
    //        let videoIcon = UIImageView(frame: CGRect(x: self.view.frame.width * 0.45 - 8, y: lineView.frame.maxY + 8, width: 16, height: 16))
    //        videoIcon.image = UIImage(named: "video-camera")
    //        whiteView.addSubview(videoIcon)
    //        let videoText = UILabel(frame: CGRect(x: videoIcon.frame.maxX + 5, y: lineView.frame.maxY + 7, width: 100, height: 30))
    //        videoText.text = "Video"
    //        videoText.font = UIFont.systemFont(ofSize: 16)
    //        videoText.textColor = UIColor.black
    //        videoText.sizeToFit()
    //        whiteView.addSubview(videoText)
    //
    //        let runIcon = UIImageView(frame: CGRect(x: self.view.frame.width * 0.8 - 8, y: lineView.frame.maxY + 7, width: 16, height: 16))
    //        runIcon.image = UIImage(named: "running-icon")
    //        whiteView.addSubview(runIcon)
    //        let runText = UILabel(frame: CGRect(x: runIcon.frame.maxX + 5, y: lineView.frame.maxY + 7, width: 100, height: 30))
    //        runText.text = "Run"
    //        runText.font = UIFont.systemFont(ofSize: 16)
    //        runText.textColor = UIColor.black
    //        runText.sizeToFit()
    //        whiteView.addSubview(runText)
    //
    //        view.addSubview(whiteView)
    //        view.sendSubviewToBack(whiteView)
    //    }
    
    //    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    //        return self.addPostHeight
    //    }
    
    
    
}
