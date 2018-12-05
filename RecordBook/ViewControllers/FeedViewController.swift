//
//  FeedViewController.swift
//  RecordBook
//
//  Created by Boris Yue on 11/28/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    var previousOffset: CGFloat = 0
    let boxOffset: CGFloat = 10
    let addPostHeight: CGFloat = 130
    var tableView: UITableView!
    var addPostView: UIView!
    var addPostTextInput: UITextField!
    // Not connected to firebase yet, so manually create posts
    var posts: [Post] = Data.posts
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.lightGrayColor
        setUpNavBar()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.barTintColor = .white
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    func setUpNavBar() {
        self.navigationController?.navigationBar.barTintColor = Constants.lightBlueColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26)]
        self.navigationItem.title = "Feed"

    }
    
    func setUpUI() {
        setUpTableView()
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func setUpTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: (navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.height), style: .grouped)
        tableView.register(FeedViewCell.self, forCellReuseIdentifier: "feedCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.sectionHeaderHeight = addPostHeight
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height / 10, right: 0)
        tableView.tableFooterView = UIView() // gets rid of the extra cells beneath
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
    }

}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview() //remove stuff from cell before initializing
        }
        cell.awakeFromNib() //initialize cell
        let currentPost = posts[posts.count - 1 - indexPath.row]
        // PICTURE
        cell.userPicture.image = currentPost.userPicture
        // USERNAME
        cell.userName.text = currentPost.userName
        cell.userName.sizeToFit()
        cell.userName.frame.origin.y -= cell.userName.frame.height / 2
        // DATETIME
        cell.dateTime.text = currentPost.dateTime
        cell.dateTime.sizeToFit()
        cell.dateTime.frame.origin.x -= cell.dateTime.frame.width
        // POST TEXT
        cell.postText.text = currentPost.postText
        // POST IMAGE
        cell.postPicture.image = currentPost.postPicture
        cell.postPicture.frame.origin.y += cell.postText.frame.maxY
        // LIKE ICON AND TEXT
        cell.likeIcon.frame.origin.y += cell.postPicture.frame.maxY
        cell.likeLabel.text = currentPost.numLikes
        cell.likeLabel.sizeToFit()
        cell.likeLabel.frame.origin.x += cell.likeIcon.frame.maxX
        cell.likeLabel.frame.origin.y = cell.likeIcon.frame.minY - 1
        // COMMENT ICON AND TEXT
        cell.commentIcon.frame.origin.x += cell.likeLabel.frame.maxX
        cell.commentIcon.frame.origin.y += cell.postPicture.frame.maxY
        cell.commentLabel.text = currentPost.numComments
        cell.commentLabel.sizeToFit()
        cell.commentLabel.frame.origin.x += cell.commentIcon.frame.maxX
        cell.commentLabel.frame.origin.y = cell.commentIcon.frame.minY - 1
        // SHARE ICON AND TEXT
        cell.shareIcon.frame.origin.x += cell.commentLabel.frame.maxX
        cell.shareIcon.frame.origin.y += cell.postPicture.frame.maxY
        cell.shareLabel.text = currentPost.numShares
        cell.shareLabel.sizeToFit()
        cell.shareLabel.frame.origin.x += cell.shareIcon.frame.maxX
        cell.shareLabel.frame.origin.y = cell.shareIcon.frame.minY - 1
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { //makes the cells smaller
        cell.contentView.backgroundColor = Constants.lightGrayColor
        let whiteView : UIView = UIView(frame: CGRect(x: 0, y: 10, width: cell.contentView.frame.width, height: cell.contentView.frame.height - 10))
        whiteView.layer.backgroundColor = UIColor.white.cgColor
        whiteView.layer.shadowOffset = CGSize(width: 0, height: 0)
        whiteView.layer.shadowOpacity = 0.2
        whiteView.layer.shadowRadius = 3
        cell.contentView.addSubview(whiteView)
        cell.contentView.sendSubviewToBack(whiteView)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: boxOffset, y: (navigationController?.navigationBar.frame.maxY)! + boxOffset, width: self.view.frame.width - boxOffset * 2, height: addPostHeight + 10))
        view.backgroundColor = Constants.lightGrayColor
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = Constants.lightGrayColor
        let whiteView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: self.addPostHeight))
        whiteView.layer.backgroundColor = UIColor.white.cgColor
        whiteView.layer.shadowOffset = CGSize(width: 0, height: 0)
        whiteView.layer.shadowOpacity = 0.2
        whiteView.layer.shadowRadius = 3
        let addPostTextInput = UITextField(frame: CGRect(x: boxOffset+5, y: boxOffset+5, width: whiteView.frame.width - boxOffset * 2, height: whiteView.frame.height * 0.6))
        addPostTextInput.delegate = self
        addPostTextInput.font = UIFont.systemFont(ofSize: 16)
        addPostTextInput.textColor = Constants.darkGrayColor
        addPostTextInput.placeholder = "Type your status update..."
        addPostTextInput.contentVerticalAlignment = .top
        addPostTextInput.clearsOnBeginEditing = true
        addPostTextInput.textColor = UIColor.black
        addPostTextInput.tintColor = Constants.darkGrayColor
        addPostTextInput.returnKeyType = .go
        whiteView.addSubview(addPostTextInput)
        // Make keyboard disappear on tap
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        // Add horizontal line in between
        let lineView = UIView(frame: CGRect(x: 0, y: addPostTextInput.frame.maxY, width: whiteView.frame.width, height: 1))
        lineView.layer.borderWidth = 3
        lineView.layer.borderColor = Constants.lightGrayColor.cgColor
        lineView.layer.opacity = 0.8
        whiteView.addSubview(lineView)
        
        // Add attachment options
        let pictureIcon = UIImageView(frame: CGRect(x: self.view.frame.width * 0.1 - 8, y: lineView.frame.maxY + 8, width: 16, height: 16))
        pictureIcon.image = UIImage(named: "picture")
        whiteView.addSubview(pictureIcon)
        let pictureText = UILabel(frame: CGRect(x: pictureIcon.frame.maxX + 5, y: lineView.frame.maxY + 7, width: 100, height: 30))
        pictureText.text = "Photo"
        pictureText.font = UIFont.systemFont(ofSize: 16)
        pictureText.textColor = UIColor.black
        pictureText.sizeToFit()
        whiteView.addSubview(pictureText)
        
        let videoIcon = UIImageView(frame: CGRect(x: self.view.frame.width * 0.45 - 8, y: lineView.frame.maxY + 8, width: 16, height: 16))
        videoIcon.image = UIImage(named: "video-camera")
        whiteView.addSubview(videoIcon)
        let videoText = UILabel(frame: CGRect(x: videoIcon.frame.maxX + 5, y: lineView.frame.maxY + 7, width: 100, height: 30))
        videoText.text = "Video"
        videoText.font = UIFont.systemFont(ofSize: 16)
        videoText.textColor = UIColor.black
        videoText.sizeToFit()
        whiteView.addSubview(videoText)

        let runIcon = UIImageView(frame: CGRect(x: self.view.frame.width * 0.8 - 8, y: lineView.frame.maxY + 7, width: 16, height: 16))
        runIcon.image = UIImage(named: "running-icon")
        whiteView.addSubview(runIcon)
        let runText = UILabel(frame: CGRect(x: runIcon.frame.maxX + 5, y: lineView.frame.maxY + 7, width: 100, height: 30))
        runText.text = "Run"
        runText.font = UIFont.systemFont(ofSize: 16)
        runText.textColor = UIColor.black
        runText.sizeToFit()
        whiteView.addSubview(runText)
        
        view.addSubview(whiteView)
        view.sendSubviewToBack(whiteView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.addPostHeight
    }
}

extension FeedViewController: UITextFieldDelegate {
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // became first responder
        print("TextField did begin editing method called")
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
        print("TextField did end editing method called")
    }
}
