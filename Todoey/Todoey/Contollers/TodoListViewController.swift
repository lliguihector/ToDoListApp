//
//  ViewController.swift
//  Todoey
//
//  Created by Hector Lliguichuzca on 5/5/23.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        let newItem = Item()
        newItem.title = "Find Milk"
        itemArray.append(newItem)
        
        
        let newItem1 = Item()
        newItem1.title = "Buy Eggs"
        itemArray.append(newItem1)
        
        
        let newItem2 = Item()
        newItem2.title = "Destroy nunu"
        itemArray.append(newItem2)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }

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

        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
      
    
        tableView.reloadData()
      
    }

    
    
    //MARK - Add New item
    @IBAction func addButtonPressed(_ sender: Any) {
        
        var textField = UITextField()
        
        
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default){ (action) in
            //what will happen once the user clicks the add button on our UIAlert
            print("Sucess!")
            
            let newItem = Item()
            newItem.title = textField.text!
            
            print(textField.text!)
            self.itemArray.append(newItem)

            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
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
}

