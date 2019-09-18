//
//  ViewController.swift
//  Todoey
//
//  Created by Apurva Katti on 9/12/19.
//  Copyright © 2019 Apurva Katti. All rights reserved.
//

import UIKit

class todoViewController: UITableViewController
{

    var item_array = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        print(dataFilePath!)
    
        loadItems()
        
        
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item_array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        cell.textLabel?.text = item_array[indexPath.row].title
        
        if item_array[indexPath.row].done == true{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        
        
        
        return cell
    }
    
   
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        //print(item_array[indexPath.row])
        
         if item_array[indexPath.row].done == false
         {
            item_array[indexPath.row].done = true
        }
         else{
            item_array[indexPath.row].done = false
        }
        
        saveData()
    
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func additems(_ sender: UIBarButtonItem)
    {
        
        var textTemp = UITextField()
        
        let alert = UIAlertController.init(title: "add new item to list", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "add item", style: .default)
        { (action) in
            
            let newItem = Item()
            
            newItem.title = textTemp.text!
            
            self.item_array.append(newItem)
            self.saveData()
            
        }
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "add new item"
            textTemp = alertTextField
            //print(textTemp)
           
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    func saveData()
    {
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(item_array)
            try data.write(to: dataFilePath!)
        }catch
        {
            print("error encoding data")
        }
        
        self.tableView.reloadData()
    }
    
    
    func loadItems()
    {
        if let unwrapped = try? Data(contentsOf: dataFilePath!)
        {
            let decoder = PropertyListDecoder()
            do
            {
                item_array = try decoder.decode([Item].self, from: unwrapped)
        }catch
        {
            print("error decoding the data")
            }
    }
    
    
}
}

