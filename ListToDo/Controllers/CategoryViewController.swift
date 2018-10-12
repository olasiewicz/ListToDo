//
//  CategoryViewController.swift
//  ListToDo
//
//  Created by Olasiewicz,  Wojciech on 10/11/18.
//  Copyright © 2018 Olasiewicz,  Wojciech. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var categoriesArray = [Category]()
    
    var indexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        
        var textFromTextField = UITextField()
        
        let alert = UIAlertController(title: "ADD NEW CATEGORY", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add cetegory", style: .default) { (akcja) in
            //what will happen when user click add button on UIAlert
            
            let newCategory = Category(context: self.context)
            
            newCategory.name = textFromTextField.text!
            
            self.categoriesArray.append(newCategory)
            
            // self.defaults.set(self.array, forKey: "ToDoList")
            self.saveData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textFromTextField = alertTextField
            print(textFromTextField)
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
    //MARK: - TableView Datasource Methods
    
    //MARK: - TableView Delegate Methods - 
    
    //MARK: - TableView DataManipulation Methods - saving etc
    
    //MARK: - Add new categories
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categoriesArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TableViewController
        
        if indexPath != nil  {
            destinationVC.selectedCategory = categoriesArray[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    
    
    func saveData() {
        
        
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categoriesArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        tableView.reloadData()
    }

}

