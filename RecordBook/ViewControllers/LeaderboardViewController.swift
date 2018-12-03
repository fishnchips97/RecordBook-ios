//
//  LeaderboardViewController.swift
//  RecordBook
//
//  Created by Erik Fisher on 11/29/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let list = ["1. Boris - 5:20", "2. Marina - 5:30", "3. Amy - 5:32", "4. Aviral - 5:35", "5. Erik - 5:37"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    

    var leaderboardView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeaderboard()
        // Do any additional setup after loading the view.
    }
    func setupLeaderboard() {
        leaderboardView = UITableView()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
