//
//  ViewController.swift
//  ListToDo
//
//  Created by Olasiewicz,  Wojciech on 10/5/18.
//  Copyright © 2018 Olasiewicz,  Wojciech. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var array = ["hej", "by eggs", "hello"]
    
    let defaults = UserDefaults.standard

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
        
        
        if let item  = defaults.array(forKey: "arrayTodo") as? [String] {
            array = item
        }
        
        
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
    
    //MARK - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFromTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (akcja) in
            //what will happen when user click add button on UIAlert
            
            self.array.append(textFromTextField.text!)
            self.defaults.set(self.array, forKey: "arrayTodo")
            
            self.tableView.reloadData()
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textFromTextField = alertTextField
            print(textFromTextField)
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
}

