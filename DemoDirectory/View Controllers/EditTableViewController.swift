//
//  EditTableViewController.swift
//  DemoDirectory
//
//  Created by 黃昌齊 on 2021/6/11.
//

import UIKit
import CoreData

class EditTableViewController: UITableViewController {
    
    var directory: Directory?
    var result: Bool? //辨識是否要編輯還是新增
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let num = directory?.number, let firstName = directory?.firstName, let lastName = directory?.lastName, let company = directory?.company {
            firstNameTextField.text = firstName
            lastNameTextField.text = lastName
            companyTextField.text = company
            phoneNumTextField.text = String(num)
        }
    }
    //按Done收鍵盤
    @IBAction func dismissFirstNameKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func dismissLastNameKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    @IBAction func dismissCompanyKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    //返回前一頁
    @IBAction func returnBack(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    */
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //辨識新增資料或修改資料
        if result == true {
            updateData()
        } else {
            saveData(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", company: companyTextField.text ?? "", number: phoneNumTextField.text ?? "")
        }
    }
    //新增資料
    func saveData(firstName: String, lastName: String, company: String, number: String) {
        let directory = Directory(context: appDelegate.persistentContainer.viewContext)
        directory.firstName = firstName
        directory.lastName = lastName
        directory.company = company
        directory.number = number
        do {
            try appDelegate.saveContext()
        } catch {
            fatalError("\(error)")
        }
    }
    //更新資料
    func updateData() {
        directory?.firstName = firstNameTextField.text
        directory?.lastName = lastNameTextField.text
        directory?.company = companyTextField.text
        directory?.number = phoneNumTextField.text
        do {
            try appDelegate.saveContext()
        } catch {
            fatalError("\(error)")
        }
    }
    
}
