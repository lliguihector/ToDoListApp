//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Hector Lliguichuzca on 5/17/23.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController{

    
    //Hold Categories mutable array
    var categories = [Category]()
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        loadCategories()
        
    }
    
    
    
    
    

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        
      
        
        return categories.count
        
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let category = categories[indexPath.row]
        cell.textLabel?.text = category.name
        
        
        return cell
    }
    
    
//MARK: - Data Manipulation Methods
    
    func loadCategories(){
        
        
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categories = try context.fetch(request)
        }catch{
            print("Error fetching data from context \(error)")
        }
        
        
        self.tableView.reloadData()
    }
    
    
    
    func saveCategories(){
        
        
        do{
            try context.save()
        }catch{
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()

    }
    
    
    
    
//MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categories[indexPath.row]
            
        }
        
    }
    
    
    
//MARK: - Add New Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem){
        
        var textField = UITextField()
        
        
        
        let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default){ (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            self.categories.append(newCategory)
            self.saveCategories()
            
        }
        
        
        alert.addAction(action)
        
        alert.addTextField{ (field) in
            
            textField = field
            field.placeholder = "Create new Category"
            
        }
        
  
        present(alert, animated: true, completion:  nil)
        
        
        
    }
    
    
    
    
    
    //MARK: - TableView Delegate Methods
    
    
    
    
    
    

  

}
