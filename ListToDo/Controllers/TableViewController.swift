//
//  ViewController.swift
//  ListToDo
//
//  Created by Olasiewicz,  Wojciech on 10/5/18.
//  Copyright © 2018 Olasiewicz,  Wojciech. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var array = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Kup jajka"
        array.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Zadzwon"
        array.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "napraw"
        array.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Ugotuj"
        array.append(newItem3)
        
        
        if let savedArray  = defaults.array(forKey: "ToDoList") as? [Item] {
            array = savedArray
        }
        
        
    }
    
    //********************************************************

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "toDoCell")
        
        let item = array[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.isChecked ? .checkmark : .none
        
        
        if item.isChecked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
        
    }
    
    
    //********************************************************
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    
    
    //********************************************************
    
    
    
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print(array[indexPath.row])
        
        
        array[indexPath.row].isChecked = !array[indexPath.row].isChecked
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
    
    //********************************************************
    
    
    
    //MARK - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFromTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (akcja) in
            //what will happen when user click add button on UIAlert
            
            let item = Item()
            item.title = textFromTextField.text!
            
            self.array.append(item)
        
            
            
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

