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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.lightGrayColor
        setUpNavBar()
        setUpUI()
    }
    
    func setUpNavBar() {
        self.navigationController?.navigationBar.barTintColor = Constants.lightBlueColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26)]
        self.navigationItem.title = "Feed"

    }
    
    func setUpUI() {
        setUpAddPost()
        setUpTableView()
    }
    
    func setUpAddPost() {
        addPostView = UIView(frame: CGRect(x: boxOffset, y: (navigationController?.navigationBar.frame.maxY)! + boxOffset, width: view.frame.width - boxOffset * 2, height: addPostHeight))
        addPostView.backgroundColor = Constants.lightGrayColor
//        addPostView.clipsToBounds = true
//        addPostView.layer.cornerRadius = 5
//        addPostView.dropShadow(color: UIColor.black, opacity: 0.05, offSet: CGSize(width: 0, height: 0), radius: 3, scale: true)
        // Add text input
//        addPostTextInput = UITextField(frame: CGRect(x: boxOffset, y: boxOffset, width: addPostView.frame.width - boxOffset * 2, height: addPostView.frame.height * 0.6))
//        addPostTextInput.delegate = self
//        addPostTextInput.font = UIFont.systemFont(ofSize: 16)
//        addPostTextInput.textColor = Constants.lightGrayColor
//        addPostTextInput.placeholder = "Type your status update..."
//        addPostTextInput.contentVerticalAlignment = .top
//        addPostTextInput.clearsOnBeginEditing = true
//        addPostView.addSubview(addPostTextInput)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
//        view.addSubview(addPostView)
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
        tableView.rowHeight = 200
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.frame.height / 10, right: 0)
        tableView.tableFooterView = UIView() // gets rid of the extra cells beneath
        tableView.allowsSelection = false
        tableView.backgroundColor = .clear
//        tableView.tableHeaderView = addPostView
//        tableView.backgroundColor = UIColor(red: 75/255, green: 184/255, blue: 147/255, alpha: 1.0)
//        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(tableView)
    }

}

extension FeedViewController: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview() //remove stuff from cell before initializing
        }
        cell.awakeFromNib() //initialize cell
//        cell.delegate = self
//        let currentPost = posts[posts.count - 1 - indexPath.row] //show most recent posts first
//        cell.tag = posts.count - 1 - indexPath.row //associate row number with each cell
//        currentPost.getProfilePic(withBlock: {(image) in
//            cell.eventPicture.image = image
//        })
//        cell.username.text = currentPost.name
        // PICTURE
        cell.userPicture.image = UIImage(named: "boris")
        // USERNAME
        cell.userName.text = "Boris Yue"
        cell.userName.sizeToFit()
        cell.userName.frame.origin.y -= cell.userName.frame.height / 2
        // DATETIME
        cell.dateTime.text = "Nov 26 2017, 5:00 PM"
        cell.dateTime.sizeToFit()
        cell.dateTime.frame.origin.x -= cell.dateTime.frame.width
        // POST TEXT
        cell.postText.text = "Went on a really great run yesterday with amazing scenery and it was crazy!!!! Would recommend :)"
        // POST IMAGE
        cell.postPicture.image = UIImage(named: "running.jpg")
        cell.postPicture.frame.origin.y += cell.postText.frame.maxY
        // LIKE ICON AND TEXT
        cell.likeIcon.frame.origin.y += cell.postPicture.frame.maxY
        cell.likeLabel.text = "5"
        cell.likeLabel.sizeToFit()
        cell.likeLabel.frame.origin.x += cell.likeIcon.frame.maxX
        cell.likeLabel.frame.origin.y = cell.likeIcon.frame.minY - 1
        // COMMENT ICON AND TEXT
        cell.commentIcon.frame.origin.x += cell.likeLabel.frame.maxX
        cell.commentIcon.frame.origin.y += cell.postPicture.frame.maxY
        cell.commentLabel.text = "2"
        cell.commentLabel.sizeToFit()
        cell.commentLabel.frame.origin.x += cell.commentIcon.frame.maxX
        cell.commentLabel.frame.origin.y = cell.commentIcon.frame.minY - 1
        // SHARE ICON AND TEXT
        cell.shareIcon.frame.origin.x += cell.commentLabel.frame.maxX
        cell.shareIcon.frame.origin.y += cell.postPicture.frame.maxY
        cell.shareLabel.text = "1"
        cell.shareLabel.sizeToFit()
        cell.shareLabel.frame.origin.x += cell.shareIcon.frame.maxX
        cell.shareLabel.frame.origin.y = cell.shareIcon.frame.minY - 1
//        cell.eventName.sizeToFit()
//        cell.eventName.frame.origin.x = cell.contentView.frame.width / 2 - cell.eventName.frame.width / 3 + 24
//        cell.author.text = "Posted by " + currentPost.author!
//        cell.author.sizeToFit()
//        cell.author.frame.origin.x = cell.eventName.frame.minX - cell.author.frame.width / 2 + cell.eventName.frame.width / 2
//        cell.date.text = currentPost.date!
//        cell.date.sizeToFit()
//        cell.date.frame.origin.x = tableView.frame.width - cell.date.frame.width - 7
//        cell.timeIcon.frame.origin.x = cell.date.frame.minX - 20
//        cell.timeIcon.frame.origin.y = 12
//        addPostObserver(forPost: currentPost, updateCell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { //makes the cells smaller
        cell.contentView.backgroundColor = Constants.lightGrayColor
        let whiteView : UIView = UIView(frame: CGRect(x: 10, y: 10, width: cell.contentView.frame.width - 20, height: cell.contentView.frame.height - 10))
        whiteView.layer.backgroundColor = UIColor.white.cgColor
        whiteView.layer.shadowOffset = CGSize(width: 0, height: 0)
        whiteView.layer.shadowOpacity = 0.05
        whiteView.layer.shadowRadius = 3
        whiteView.layer.cornerRadius = 5
        cell.contentView.addSubview(whiteView)
        cell.contentView.sendSubviewToBack(whiteView)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        postToPass = posts[posts.count - 1 - indexPath.row]
//        self.performSegue(withIdentifier: "toDetail", sender: self)
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }

//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentOffset = scrollView.contentOffset.y
//        var originalFrame = self.addPostView.frame
//        if self.previousOffset == 0 {
//            self.previousOffset = currentOffset
//        }
//        originalFrame.origin.y += (self.previousOffset - currentOffset)
//        self.previousOffset = currentOffset
//        self.addPostView.frame = originalFrame
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: boxOffset, y: (navigationController?.navigationBar.frame.maxY)! + boxOffset, width: self.view.frame.width - boxOffset * 2, height: addPostHeight + 10))
        view.backgroundColor = Constants.lightGrayColor
        return view
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = Constants.lightGrayColor
        let whiteView = UIView(frame: CGRect(x: boxOffset, y: boxOffset, width: view.frame.width - boxOffset * 2, height: self.addPostHeight))
        whiteView.layer.backgroundColor = UIColor.white.cgColor
        whiteView.layer.shadowOffset = CGSize(width: 0, height: 0)
        whiteView.layer.shadowOpacity = 0.05
        whiteView.layer.shadowRadius = 3
        whiteView.layer.cornerRadius = 5
        whiteView.layer.zPosition = 100
        view.addSubview(whiteView)
        view.sendSubviewToBack(whiteView)
        print(whiteView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.addPostHeight + 10
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
