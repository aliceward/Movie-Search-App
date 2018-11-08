//
//  Favorites.swift
//  AliceWard-Lab4
//
//  Created by Alice Ward on 10/22/18.
//  Copyright © 2018 Alice Ward. All rights reserved.
//

import Foundation
import UIKit

class Favorites: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    var favoriteTitles:[String] = []
    
    override func viewDidAppear(_ animated: Bool) {
        let UserDefault = UserDefaults.standard
        let favorites = UserDefault.array(forKey: "Favorites") as? [String]
        self.favoriteTitles = favorites!
        tableView.reloadData()
    }
    
    //Protocol Stubs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteTitles.count
    }
    func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "favCell")
        cell.textLabel?.text = favoriteTitles[indexPath.row]
        return cell
    }
    
    //Delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            favoriteTitles.remove(at: indexPath.row)
            UserDefaults.standard.set(favoriteTitles, forKey: "Favorites")
            tableView.reloadData()
        }
    }
    
    //Creative = Moving cells - https://developer.apple.com/documentation/uikit/uitableview
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let cell = favoriteTitles[sourceIndexPath.row]
        favoriteTitles.remove(at: sourceIndexPath.row)
        favoriteTitles.insert(cell, at: destinationIndexPath.row)
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
