//
//  WatchList.swift
//  AliceWard-Lab4
//
//  Created by Alice Ward on 10/24/18.
//  Copyright © 2018 Alice Ward. All rights reserved.
//

import Foundation
import UIKit

class WatchList: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        if self.tableView.isEditing == true {
            self.tableView.isEditing = false
            editButton.title = "Edit"
        } else {
            self.tableView.isEditing = true
            editButton.title = "Done"
        }
    }

    var watchListTitles:[String] = []

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchListTitles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "watchCell")
        cell.textLabel?.text = watchListTitles[indexPath.row]
        return cell
    }
    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    //Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            watchListTitles.remove(at: indexPath.row)
            UserDefaults.standard.set(watchListTitles, forKey: "WatchList")
            tableView.reloadData()
        }
    }
    
    //Creative = Moving cells - https://developer.apple.com/documentation/uikit/uitableview
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let cell = watchListTitles[sourceIndexPath.row]
        watchListTitles.remove(at: sourceIndexPath.row)
        watchListTitles.insert(cell, at: destinationIndexPath.row)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let UserDefault = UserDefaults.standard
        let watchList = UserDefault.array(forKey: "WatchList") as? [String]
        self.watchListTitles = watchList!
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareTableView()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

