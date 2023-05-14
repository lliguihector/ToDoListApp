//
//  ViewController.swift
//  Todoey
//
//  Created by Hector Lliguichuzca on 5/5/23.
//

import UIKit

class TodoListViewController: UITableViewController {

    
    var itemArray = [Item]()
    let dataFliePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()

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
      
       saveItems()
      
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
    
    
    
    func saveItems(){
        
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFliePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFliePath!){
            
            let decoder = PropertyListDecoder()
            
            do{
            itemArray = try decoder.decode([Item].self, from: data)
            
            }catch{
                print("Error decoding item array, \(error) ")
            }
        
    }
}

}
