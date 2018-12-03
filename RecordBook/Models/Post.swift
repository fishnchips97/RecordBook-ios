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

class Post {
    
    var userPicture: UIImage?
    var userName: String?
    var dateTime: String?
    var postPicture: UIImage?
    var postText: String?
    var numLikes: String?
    var numComments: String?
    var numShares: String?
    
    init(postDict: [String:Any]?) {
        if let userPicture = postDict!["userPicture"] as? UIImage {
            self.userPicture = userPicture
        }
        if let userName = postDict!["userName"] as? String {
            self.userName = userName
        }
        if let dateTime = postDict!["dateTime"] as? String {
            self.dateTime = dateTime
        }
        if let postPicture = postDict!["postPicture"] as? UIImage {
            self.postPicture = postPicture
        }
        if let postText = postDict!["postText"] as? String {
            self.postText = postText
        }
        if let numLikes = postDict!["numLikes"] as? String {
            self.numLikes = numLikes
        }
        if let numComments = postDict!["numComments"] as? String {
            self.numComments = numComments
        }
        if let numShares = postDict!["numShares"] as? String {
            self.numShares = numShares
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
