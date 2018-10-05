//
//  ViewController.swift
//  ListToDo
//
//  Created by Olasiewicz,  Wojciech on 10/5/18.
//  Copyright © 2018 Olasiewicz,  Wojciech. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let array = ["hej", "by eggs", "hello"]

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        cell.textLabel?.text = array[indexPath.row]
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(array[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

