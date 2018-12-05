//
//  Data.swift
//  RecordBook
//
//  Created by Boris Yue on 12/4/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import Foundation
import UIKit

//Haven't connected to Firebase yet, so using dummy data
struct Data {
    
    
    static let posts = [Post(postDict: ["userPicture": UIImage(named: "boris"), "userName": "Boris Yue", "dateTime": "Nov 26 2017, 5:00 PM", "postPicture": UIImage(named: "running.jpg"), "postText": "Went on a really great run yesterday with amazing scenery and it was crazy!!!! Would recommend :)", "numLikes": "5", "numComments": "2", "numShares": "1"]),
                        Post(postDict: ["userPicture": UIImage(named: "aviral"), "userName": "Aviral Pereira", "dateTime": "Nov 28 2017, 5:36 PM", "postPicture": UIImage(named: "running3.jpg"), "postText": "Great run today!", "numLikes": "18", "numComments": "5", "numShares": "0"]),
                        Post(postDict: ["userPicture": UIImage(named: "erik"), "userName": "Erik Fisher", "dateTime": "Nov 28 2017, 6:23 PM", "postPicture": UIImage(named: "running2.jpg"), "postText": "Got a new personal record today for the mile at 4:26! #StriveForGreatness", "numLikes": "29", "numComments": "6", "numShares": "3"])]
    
    static let nationalRankings = [
        User(postDict: ["userPicture": UIImage(named: "erik"), "userName": "Erik Fisher", "nationalRank": 1, "stateRank": 1, "cityRank": 1, "mileTime": "4:02"]),
        User(postDict: ["userPicture": UIImage(named: "aviral"), "userName": "Aviral Pereira", "nationalRank": 2, "stateRank": 1, "cityRank": 1, "mileTime": "4:15"]),
        User(postDict: ["userPicture": UIImage(named: "amy.jpg"), "userName": "Amy Zhang", "nationalRank": 3, "stateRank": 3, "cityRank": 1, "mileTime": "4:21"]),
        User(postDict: ["userPicture": UIImage(named: "boris"), "userName": "Boris Yue", "nationalRank": 4, "stateRank": 4, "cityRank": 1, "mileTime": "4:27"]),
        User(postDict: ["userPicture": UIImage(named: "marina.jpg"), "userName": "Marina Kim", "nationalRank": 5, "stateRank": 4, "cityRank": 1, "mileTime": "4:50"])]
    
    static let stateRankings = [User(postDict: ["userPicture": UIImage(named: "boris"), "userName": "Boris Yue", "nationalRank": 4, "stateRank": 1, "cityRank": 1, "mileTime": "4:27"])]
    
    static let cityRankings = [User(postDict: ["userPicture": UIImage(named: "boris"), "userName": "Boris Yue", "nationalRank": 4, "stateRank": 1, "cityRank": 1, "mileTime": "4:27"])]
    
    static let leaderboard = Leaderboard(postDict: ["nationalRankings": nationalRankings, "stateRankings": stateRankings, "cityRankings": cityRankings])
    
    static let loggedInUser = User(postDict: ["userPicture": UIImage(named: "boris"), "userName": "Boris Yue", "nationalRank": 4, "stateRank": 1, "cityRank": 1, "mileTime": "4:27"])
    
}
