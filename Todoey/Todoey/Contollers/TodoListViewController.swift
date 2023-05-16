//
//  ViewController.swift
//  Todoey
//
//  Created by Hector Lliguichuzca on 5/5/23.
//

import UIKit
import CoreData
class TodoListViewController: UITableViewController{

    let searchController = UISearchController(searchResultsController: nil)

    
 
   
    var itemArray = [Item]()
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        
        
        
        searchController.delegate = self
        
 
        
        
        
        loadItems()

        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    
    
    
    //MARK - Tableview Datasource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        
        cell.accessoryType = item.done ? .checkmark : .none
        
    
        return cell
    }
    
    //MARK - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
       itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
       saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
      
    }

    

    
    //MARK - Add New item
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            //what will happen once the user clicks the add button on our UIAlert
            print("Sucess!")

            let newItem = Item(context: self.context)
            newItem.done = false
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
 
        }
        
        
        alert.addTextField{ (alertTextField) in
            alertTextField.placeholder? = "Create new item"
            textField = alertTextField
            
            print(alertTextField.text!)
            print(textField)
            print("Now")
          
        }
        
        
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
    //CREATE
    func saveItems(){

        do{
           try context.save()
        }catch{
        print("Error saving context \(error)")
        }
        
        
        self.tableView.reloadData()
        
    }
    
    //READ
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()){
        
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        do{
           itemArray = try context.fetch(request)
            
        }catch{
            print("Error fetching data from context \(error)")
        }
        
        self.tableView.reloadData()

}

}


//MARK - UISEARCH RESULTS UPDATING


extension TodoListViewController: UISearchResultsUpdating{
    
    
    func updateSearchResults(for searchController: UISearchController) {

        
        guard let searchText = searchController.searchBar.text else{
            
            return
        }
        
        
        
        if searchText.isEmpty{
            loadItems()
        }else{
            print(searchText)
            
            
            let request: NSFetchRequest<Item> = Item.fetchRequest()
            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            
    
            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
            
            loadItems(with: request)
        }
        }
        
//        if let searchText = searchController.searchBar.text{
//            // Implement your search logic here and update your search results
//            print(searchText)
//
//
//            let request: NSFetchRequest<Item> = Item.fetchRequest()
//            request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
//
//
//            request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
//
//            loadItems(with: request)
//        }

    
    
}


//MARK -

extension TodoListViewController: UISearchControllerDelegate{

    //Reloads Table View data when pressed cancelled on search bar
    func didDismissSearchController(_ searchController: UISearchController) {
           loadItems()
       }
}
