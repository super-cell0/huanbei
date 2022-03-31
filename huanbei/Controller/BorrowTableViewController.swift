//
//  BorrowTableViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/13.
//

import UIKit

class BorrowTableViewController: UITableViewController {
    
    struct Borrow: Codable {
        var checked: Bool = false
        var name: String = ""
    }
    
    var borrows: [Borrow] = []
    var row = 0

    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "借入记录"
        
        if let data = UserDefaults.standard.data(forKey: "borrows") {
            do {
                borrows = try JSONDecoder().decode([Borrow].self, from: data)
            } catch  {
                print("解码失败",error)
            }
        }
        
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return borrows.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kBorrowIdentifier, for: indexPath) as! BorrowTableViewCell

        cell.checkButton.isSelected = borrows[indexPath.row].checked
        cell.nameLabel.text = borrows[indexPath.row].name
        if #available(iOS 13.0, *) {
            cell.nameLabel.textColor = borrows[indexPath.row].checked ? .tertiaryLabel : .label
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 14.0, *) {
            cell.checkButton.addAction(UIAction(handler: { action in
                //            self.borrows[indexPath.row].checked = !self.borrows[indexPath.row].checked
                self.borrows[indexPath.row].checked.toggle()
                cell.checkButton.isSelected = self.borrows[indexPath.row].checked
                cell.nameLabel.textColor = self.borrows[indexPath.row].checked ? .tertiaryLabel : .label
                
            }), for: .touchUpInside)
        } else {
            // Fallback on earlier versions
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let borrowViewController = storyboard?.instantiateViewController(withIdentifier: "borrowViewControllerID") as! addBorrowViewController
//        self.navigationController?.pushViewController(borrowViewController, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            borrows.remove(at: indexPath.row)
            // Delete the row from the data source
            
            borrowSaveData()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        let borrowToRemove = borrows[fromIndexPath.row]
        borrows.remove(at: fromIndexPath.row)
        borrows.insert(borrowToRemove, at: to.row)
        
        borrowSaveData()
        
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! addBorrowViewController
        if segue.identifier == kAddBorrowSegue {
            vc.delegate = self
        } else if segue.identifier == "editBorrowSegue" {
            vc.delegate = self
            let cell = sender as! BorrowTableViewCell
            row = tableView.indexPath(for: cell)!.row
            vc.name = borrows[row].name
        }

    }
    
    func borrowSaveData() {
        do {
            let data = try JSONEncoder().encode(borrows)
            UserDefaults.standard.set(data, forKey: "borrows")
        } catch  {
            print(error)
        }
    }

}

extension BorrowTableViewController: addBorrowViewControllerDelegate {
    func didAdd(name: String) {
        borrows.append(Borrow(checked: false, name: name))
        
        borrowSaveData()
        
        tableView.insertRows(at: [IndexPath(row: borrows.count - 1, section: 0)], with: .automatic)
    }
    
    func didEdit(nameEdit: String) {
        borrows[row].name = nameEdit
        
        borrowSaveData()
//        let indexPath = IndexPath(row: row, section: 0)
//        let cell = tableView.cellForRow(at: indexPath) as! BorrowTableViewCell
//        cell.nameLabel.text = nameEdit
        
        tableView.reloadData()
    }
}
