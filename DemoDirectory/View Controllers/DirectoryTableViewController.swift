//
//  DirectoryTableViewController.swift
//  DemoDirectory
//
//  Created by 黃昌齊 on 2021/6/11.
//

import UIKit
import CoreData

class DirectoryTableViewController: UITableViewController {
    
    var directories = [Directory]()
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
   
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCoreData()
    }
    
    @IBAction func unwindToDirectoryTableViewController(_ unwindSegue: UIStoryboardSegue) {
        fetchCoreData()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    //抓core data資料
    func fetchCoreData(){
        if let context = appDelegate?.persistentContainer.viewContext{
            do {
                directories = try context.fetch(Directory.fetchRequest())
            } catch {
                print("error")
            }
        }
    }
    
    @IBSegueAction func showEditController(_ coder: NSCoder) -> UINavigationController? {
        let navController = UINavigationController(coder: coder)
        let controller = navController?.viewControllers.first as! EditTableViewController
        controller.result = true
        if let row = tableView.indexPathForSelectedRow?.row {
            controller.directory = directories[row]
        }
        return navController
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return directories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "directoryTableViewCell", for: indexPath) as! DirectoryTableViewCell
        let directory = directories[indexPath.row]
        cell.firstNameLabel.text = directory.firstName
        cell.lastNameLabel.text = directory.lastName

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // 刪除資料
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = appDelegate?.persistentContainer.viewContext
            do {
                var requests = try context!.fetch(Directory.fetchRequest())
                for request in requests {
                    if request.firstName == directories[indexPath.row].firstName && request.lastName == directories[indexPath.row].lastName && request.company == directories[indexPath.row].company {
                        context?.delete(request)
                    }
                }
                try appDelegate?.saveContext()
            } catch {
                fatalError("\(error)")
            }
            directories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
 
        }
    }
    
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navController = segue.destination as! UINavigationController
        let controller = navController.viewControllers.first as! EditTableViewController
        if let row = tableView.indexPathForSelectedRow?.row {
            controller.directory = directories[row]
        }
        
    }
    */
}
