//
//  LeaderboardViewController.swift
//  RecordBook
//
//  Created by Erik Fisher on 11/29/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit
import Parchment


class LeaderboardViewController: UIViewController {
    
    var users = ["1. Boris - 5:20", "2. Marina - 5:30", "3. Amy - 5:32", "4. Aviral - 5:35", "5. Erik - 5:37"]
    var leaderboardView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        setUpNavBar()
        setUpMenu()
//        setupLeaderboard()
    }
    
    func setUpMenu() {
        let nationalController = LeaderboardTable()
        let stateController = LeaderboardTable()
        let cityController = LeaderboardTable()
        nationalController.title = "National"
        stateController.title = "State"
        cityController.title = "City"
        let controllerArray = [nationalController, stateController, cityController]
        
        let pagingViewController = FixedPagingViewController(viewControllers: controllerArray)
        self.addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 90)
            ])
        pagingViewController.textColor = .black
        pagingViewController.font = UIFont.boldSystemFont(ofSize: 16)
        pagingViewController.selectedFont = UIFont.boldSystemFont(ofSize: 16)
        pagingViewController.indicatorColor = Constants.lightBlueColor
        pagingViewController.menuInteraction = .none
        pagingViewController.menuItemSize = PagingMenuItemSize.sizeToFit(minWidth: view.frame.width/3, height: 40)
    }
    
    func setUpNavBar() {
        self.navigationController?.navigationBar.barTintColor = Constants.lightBlueColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26)]
        self.navigationItem.title = "Leaderboard"
    }
    
}
