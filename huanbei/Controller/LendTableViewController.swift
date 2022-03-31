//
//  LendTableViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/13.
//

import UIKit

class LendTableViewController: UITableViewController {
    
    struct Lend: Codable {
        var lendCheck: Bool = false
        var lendNmae: String = ""
    }
    
    var lends: [Lend] = []
    var row = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "借出记录"
        
        if let data = UserDefaults.standard.data(forKey: "lends") {
            do {
                lends = try JSONDecoder().decode([Lend].self, from: data)
            } catch  {
                print("解码失败", error)
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
        return lends.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kLendIdentifier, for: indexPath) as! LendTableViewCell
        
        cell.lendCheckButton.isSelected = lends[indexPath.row].lendCheck
        cell.lendNameLabel.text = lends[indexPath.row].lendNmae
        if #available(iOS 13.0, *) {
            cell.lendNameLabel.textColor = lends[indexPath.row].lendCheck ? .tertiaryLabel : .label
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 14.0, *) {
            cell.lendCheckButton.addAction(UIAction(handler: { action in
                self.lends[indexPath.row].lendCheck.toggle()
                cell.lendCheckButton.isSelected = self.lends[indexPath.row].lendCheck
                cell.lendNameLabel.textColor = self.lends[indexPath.row].lendCheck ? .tertiaryLabel : .label
            }), for: .touchUpInside)
        } else {
            // Fallback on earlier versions
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        let lendTableViewController = storyboard?.instantiateViewController(withIdentifier: "lendTableViewControllerID") as! AddLendTableViewController
//        self.navigationController?.pushViewController(lendTableViewController, animated: true)
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
            lends.remove(at: indexPath.row)
            
            lendSaveData()
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
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
        let vc = segue.destination as! AddLendTableViewController
        if segue.identifier == KAddLendSegue {
            vc.delegate = self
        } else if segue.identifier == "editLendSegue" {
            vc.delegate = self
            let cell = sender as! LendTableViewCell
            row = tableView.indexPath(for: cell)!.row
            vc.editLendName = lends[row].lendNmae
        }
    }
    
    func lendSaveData() {
        do {
            let data = try JSONEncoder().encode(lends)
            UserDefaults.standard.set(data, forKey: "lends")
        } catch  {
            print("编码失败", error)
        }
    }
    

}

extension LendTableViewController: AddLendTableViewControllerDelegate {
    func didAdd(lendName: String) {
        lends.append(Lend(lendCheck: false, lendNmae: lendName))
        
        lendSaveData()
        
        tableView.insertRows(at: [IndexPath(row: lends.count - 1, section: 0)], with: .automatic)
    }
    
    func didEdit(lendNameEdit: String) {
        lends[row].lendNmae = lendNameEdit
        
        lendSaveData()
        
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! LendTableViewCell
        cell.lendNameLabel.text = lends[row].lendNmae
    }
}
