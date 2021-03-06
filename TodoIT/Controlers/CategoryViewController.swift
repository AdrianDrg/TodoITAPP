//
//  CategoryViewController.swift
//  TodoIT
//
//  Created by Draghici Adrian on 08/03/2018.
//  Copyright © 2018 Draghici Adrian. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        tableView.rowHeight = 80


    }
    
    //Mark: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    
    //Mark: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destiantionVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destiantionVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    
    
    //Mark: - TableView Manipulation Methods
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add a new category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { (action) in
        let newCategory = Category(context: self.context)
        newCategory.name = textField.text!
        self.categoryArray.append(newCategory)
        self.saveCategory()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //=====CREATE in CRUD=====//
    func saveCategory() {
        do{
            try context.save()
        }
        catch{
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    
    //=====READ in CRUD=====//
    func loadCategory()  {
        let request : NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Delete cell on swipe
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            
            //=====DELETE in CRUD=====//
            context.delete(categoryArray[indexPath.row])
            categoryArray.remove(at: indexPath.row)
            
            saveCategory()
            
        }
    }
}
