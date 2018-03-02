//
//  ViewController.swift
//  TodoIT
//
//  Created by Draghici Adrian on 02/03/2018.
//  Copyright © 2018 Draghici Adrian. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let itemArray = ["Find Mike","Buy Water","Kill Demagorgon","Go to Police","New Commit"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

   
    
    //MARK-Tableview Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }

}

