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

    let item_array = ["hello","apurva","atharv"]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item_array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        
        cell.textLabel?.text = item_array[indexPath.row]
        
        return cell
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        //print(item_array[indexPath.row])
        
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark)
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }


}

