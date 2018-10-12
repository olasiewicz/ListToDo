//
//  ViewController.swift
//  ListToDo
//
//  Created by Olasiewicz,  Wojciech on 10/5/18.
//  Copyright © 2018 Olasiewicz,  Wojciech. All rights reserved.
//

import UIKit
import CoreData


class TableViewController: UITableViewController {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var array = [Item]()
    
    //code in didSet when selectedCategory has value
    var selectedCategory : Category? {
        didSet{
            loadData()
        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // loadData()
        print(dataFilePath)
    
    }
    
    //********************************************************

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "toDoCell")
        
        let item = array[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.isChecked ? .checkmark : .none
        
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
        
        array[indexPath.row].setValue("Completed", forKey: "title")
        
        //array[indexPath.row].isChecked = !array[indexPath.row].isChecked
        
        context.delete(array[indexPath.row])
        array.remove(at: indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        saveData()
        
        
    }
    
    
    
    
    //********************************************************
    
    
    
    //MARK - Add new items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textFromTextField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (akcja) in
            //what will happen when user click add button on UIAlert
            
            let newItem = Item(context: self.context)
            
            newItem.title = textFromTextField.text!
            newItem.isChecked = false
            newItem.parentCategory = self.selectedCategory
            
            self.array.append(newItem)
        
           // self.defaults.set(self.array, forKey: "ToDoList")
            self.saveData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textFromTextField = alertTextField
            print(textFromTextField)
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    func saveData() {
        
       
        do {
          try context.save()
        } catch {
          print("Error saving context, \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    
    
    
    //with - external parameter
    // request - internal parameter
    //with default value
    func loadData(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
        
        
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", (selectedCategory!.name)!)
        
        if let addisionalPredicate = predicate {
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [ categoryPredicate, addisionalPredicate])
        } else {
            request.predicate = categoryPredicate
        }
        
        // polaczenie 2 query
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [ categoryPredicate, predicate!])

        
        do {
            array = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }
}

extension TableViewController: UISearchBarDelegate {
   
    //MARK: - Search bar methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        
        //query SQL
        let searchPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadData(with: request, predicate: searchPredicate)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            loadData()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
       
    }
    
}
