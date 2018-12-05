//
//  Post.swift
//  RecordBook
//
//  Created by Boris Yue on 12/2/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class User {
    
    var nationalRank: Int?
    var stateRank: Int?
    var cityRank: Int?
    var userName: String?
    var userPicture: UIImage?
    var mileTime: String?
    
    init(postDict: [String:Any]?) {
        if let userPicture = postDict!["userPicture"] as? UIImage {
            self.userPicture = userPicture
        }
        if let userName = postDict!["userName"] as? String {
            self.userName = userName
        }
        if let cityRank = postDict!["cityRank"] as? Int {
            self.cityRank = cityRank
        }
        if let stateRank = postDict!["stateRank"] as? Int {
            self.stateRank = stateRank
        }
        if let nationalRank = postDict!["nationalRank"] as? Int {
            self.nationalRank = nationalRank
        }
        if let mileTime = postDict!["mileTime"] as? String {
            self.mileTime = mileTime
        }
        
    }
    
    //    func getProfilePic(withBlock: @escaping (UIImage) -> ()) {
    //        let ref = FIRStorage.storage().reference(forURL: imageUrl!) // use image URL to download image from storage
    //        ref.data(withMaxSize: 1 * 2048 * 2048) { data, error in
    //            if let error = error {
    //                print(error)
    //            } else {
    //                self.image = UIImage(data: data!)
    //                withBlock(self.image!)
    //            }
    //        }
    //    }
    //
    //    func getInterestedUsers(withBlock: @escaping (Int) -> Void) {
    //        postRef.child(self.id!).observeSingleEvent(of: .value, with: { snapshot in
    //            let value = snapshot.value as? NSDictionary
    //            let idArray = value?["interestedUsers"] as? [String] ?? []
    //            //                for val in idArray {
    //            //                    User.generateUserModel(withId: val, withBlock: { user in //how to pass list of users??
    //            //
    //            //                    })
    //            //                }
    //            withBlock(idArray.count)
    //        })
    //    }
    //
    //    func addInterestedUser(withId: String) {
    //        if !self.interestedUsers.contains(withId) {
    //            self.interestedUsers.append(withId)
    //            let childUpdates = ["\(self.id!)/interestedUsers": self.interestedUsers]
    //            postRef.updateChildValues(childUpdates) //update interested array
    //        }
    //    }
    //
    //    func removeInterestedUser(withId: String) {
    //        self.interestedUsers.remove(at: self.interestedUsers.index(of: withId)!)
    //        let childUpdates = ["\(self.id!)/interestedUsers": self.interestedUsers]
    //        postRef.updateChildValues(childUpdates) //update interested array
    //    }
    //
    
}
