//
//  LeaderboardTableViewController.swift
//  RecordBook
//
//  Created by Boris Yue on 12/4/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit

enum LeaderboardType {
    case national
    case state
    case city
}

class LeaderboardTable: UIViewController {

    var users: [User]!
    var currentUser: User!
    var leaderboardType: LeaderboardType!
    var leaderboardView: UITableView!
    var ownRankView: UIView!
    var ownRank: UILabel!
    var ownName: UILabel!
    var ownPicture: UIImageView!
    var ownMileTime: UILabel!
    let cellHeight: CGFloat = 70
    let rankIconOffset: CGFloat = 7
    
    static var tabBarMinY: CGFloat!
    
    
    convenience init(users: [User], currentUser: User, leaderboardType: LeaderboardType) {
        self.init(nibName:nil, bundle:nil)
        self.users = users
        self.currentUser = currentUser
        self.leaderboardType = leaderboardType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setUpOwnRankView()
    }

    
    func setUpTable() {
        leaderboardView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        leaderboardView.register(LeaderboardViewCell.self, forCellReuseIdentifier: "leaderboardCell")
        leaderboardView.delegate = self
        leaderboardView.dataSource = self
        leaderboardView.separatorStyle = .none
        leaderboardView.allowsSelection = false
        view.addSubview(leaderboardView)
    }
    
    func setUpOwnRankView() {
        let fontSize: CGFloat = 18
        ownRankView = UIView(frame: CGRect(x: 0, y: LeaderboardTable.tabBarMinY! - cellHeight - 128, width: view.frame.width, height: cellHeight))
        ownRankView.backgroundColor = Constants.lightBlueColor
        // Own rank
        ownRank = UILabel(frame: CGRect(x: 20, y: 26, width: fontSize, height: fontSize))
        setUserRank(rankLabel: ownRank)
        ownRank.font = UIFont.boldSystemFont(ofSize: fontSize)
        ownRank.textColor = .white
        ownRankView.addSubview(ownRank)
        // Own Picture
        ownPicture = UIImageView(frame: CGRect(x: ownRank.frame.maxX + 15, y: 12.5, width: 45, height: 45))
        ownPicture.layer.cornerRadius = ownPicture.frame.width / 2
        ownPicture.layer.masksToBounds = true
        ownPicture.image = currentUser.userPicture
        ownRankView.addSubview(ownPicture)
        // Own Username
        ownName = UILabel(frame: CGRect(x: ownPicture.frame.maxX + 15, y: 24, width: 16, height: 16))
        ownName.text = currentUser.userName
        ownName.font = UIFont.boldSystemFont(ofSize: fontSize)
        ownName.textColor = .white
        ownName.sizeToFit()
        ownRankView.addSubview(ownName)
        // Own mile time
        ownMileTime = UILabel(frame: CGRect(x: view.frame.width - 20, y: 15, width: 16, height: 16))
        ownMileTime.text = currentUser.mileTime
        ownMileTime.font = UIFont.boldSystemFont(ofSize: 32)
        ownMileTime.textColor = .white
        ownMileTime.sizeToFit()
        ownMileTime.frame.origin.x -= ownMileTime.frame.width
        ownRankView.addSubview(ownMileTime)
        
        view.addSubview(ownRankView)
        
    }
    
    func setUserRank(rankLabel: UILabel) {
        if leaderboardType == LeaderboardType.national {
            if currentUser.nationalRank! <= 3 {
                rankLabel.frame = CGRect(x: rankLabel.frame.origin.x - rankIconOffset, y: rankLabel.frame.origin.y - 2, width: 25, height: 25) //make frame bigger
            }
            if currentUser.nationalRank == 1 {
                rankLabel.addImage(imageName: "gold-medal")
            } else if currentUser.nationalRank == 2 {
                rankLabel.addImage(imageName: "silver-medal")
            } else if currentUser.nationalRank == 3 {
                rankLabel.addImage(imageName: "bronze-medal")
            } else {
                rankLabel.text = "\(currentUser.nationalRank!)"
                rankLabel.sizeToFit()
            }
        } else if leaderboardType == LeaderboardType.state {
            if currentUser.stateRank! <= 3 {
                rankLabel.frame = CGRect(x: rankLabel.frame.origin.x - rankIconOffset, y: rankLabel.frame.origin.y - 2, width: 25, height: 25) //make frame bigger
            }
            if currentUser.stateRank == 1 {
                rankLabel.addImage(imageName: "gold-medal")
            } else if currentUser.stateRank == 2 {
                rankLabel.addImage(imageName: "silver-medal")
            } else if currentUser.stateRank == 3 {
                rankLabel.addImage(imageName: "bronze-medal")
            } else {
                rankLabel.text = "\(currentUser.stateRank!)"
                rankLabel.sizeToFit()
            }
        } else if leaderboardType == LeaderboardType.city {
            if currentUser.cityRank! <= 3 {
                rankLabel.frame = CGRect(x: rankLabel.frame.origin.x - rankIconOffset, y: rankLabel.frame.origin.y - 2, width: 25, height: 25) //make frame bigger
            }
            if currentUser.cityRank == 1 {
                rankLabel.addImage(imageName: "gold-medal")
            } else if currentUser.cityRank == 2 {
                rankLabel.addImage(imageName: "silver-medal")
            } else if currentUser.cityRank == 3 {
                rankLabel.addImage(imageName: "bronze-medal")
            } else {
                rankLabel.text = "\(currentUser.cityRank!)"
                rankLabel.sizeToFit()
            }
        }
    }
    
}

extension LeaderboardTable: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    // If rank is top 3, make an icon
    func setCellRankText(cell: LeaderboardViewCell, user: User) {
        if leaderboardType == LeaderboardType.national {
            if user.nationalRank! <= 3 {
                cell.rank.frame = CGRect(x: cell.rank.frame.origin.x - rankIconOffset, y: cell.rank.frame.origin.y - 2, width: 25, height: 25) //make frame bigger
            }
            if user.nationalRank == 1 {
                cell.rank.addImage(imageName: "gold-medal")
            } else if user.nationalRank == 2 {
                cell.rank.addImage(imageName: "silver-medal")
            } else if user.nationalRank == 3 {
                cell.rank.addImage(imageName: "bronze-medal")
            } else {
                cell.rank.text = "\(user.nationalRank!)"
                cell.rank.sizeToFit()
            }
        } else if leaderboardType == LeaderboardType.state {
            if user.stateRank! <= 3 {
                cell.rank.frame = CGRect(x: cell.rank.frame.origin.x - rankIconOffset, y: cell.rank.frame.origin.y - 2, width: 25, height: 25) //make frame bigger
            }
            if user.stateRank == 1 {
                cell.rank.addImage(imageName: "gold-medal")
            } else if user.stateRank == 2 {
                cell.rank.addImage(imageName: "silver-medal")
            } else if user.stateRank == 3 {
                cell.rank.addImage(imageName: "bronze-medal")
            } else {
                cell.rank.text = "\(user.stateRank!)"
                cell.rank.sizeToFit()
            }
        } else if leaderboardType == LeaderboardType.city {
            if user.cityRank! <= 3 {
                cell.rank.frame = CGRect(x: cell.rank.frame.origin.x - rankIconOffset, y: cell.rank.frame.origin.y - 2, width: 25, height: 25) //make frame bigger
            }
            if user.cityRank == 1 {
                cell.rank.addImage(imageName: "gold-medal")
            } else if user.cityRank == 2 {
                cell.rank.addImage(imageName: "silver-medal")
            } else if user.cityRank == 3 {
                cell.rank.addImage(imageName: "bronze-medal")
            } else {
                cell.rank.text = "\(user.cityRank!)"
                cell.rank.sizeToFit()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderboardCell") as! LeaderboardViewCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview() //remove stuff from cell before initializing
        }
        cell.awakeFromNib() //initialize cell
        let currentUser = users[indexPath.row]
        // RANK
        setCellRankText(cell: cell, user: currentUser)
        // PICTURE
        cell.userPicture.image = currentUser.userPicture
        // USERNAME
        cell.userName.text = currentUser.userName
        cell.userName.sizeToFit()
        // MILE TIME
        cell.mileTime.text = currentUser.mileTime
        cell.mileTime.sizeToFit()
        cell.mileTime.frame.origin.x -= cell.mileTime.frame.width
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lineView = UIView(frame: CGRect(x: 20, y: cell.contentView.frame.maxY, width: cell.contentView.frame.width - 40, height: 1))
        lineView.layer.borderWidth = 3
        lineView.layer.borderColor = Constants.lightGrayColor.cgColor
        lineView.layer.opacity = 0.5
        cell.contentView.addSubview(lineView)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    
}
