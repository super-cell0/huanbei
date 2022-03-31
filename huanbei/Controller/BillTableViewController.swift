//
//  BillTableViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/7.
//

import UIKit

class BillTableViewController: UITableViewController {
    
    struct Bill: Codable {
        //分期平台
        var name = ""
        //应还总额
        var payBack = ""
        //分期数
        var staging = ""
    }

    var bills: [Bill] = []
    var row = 0
    
    @IBOutlet weak var billheaderView: BillHeaderUIView!
    
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.separatorStyle = .none
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        billheaderView.netAssetLabel.text = "0.00"
        billheaderView.allAssetLabel.text = "0.00"
        billheaderView.allDebtLabel.text = "-0.00"
        
        //取数据
        if let data = UserDefaults.standard.data(forKey: "bills") {
            do {
                bills = try JSONDecoder().decode([Bill].self, from: data)
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
        return bills.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kBillreuseIdentifier, for: indexPath) as! BillTableViewCell
        
        cell.billNameLabel.text = bills[indexPath.row].name
        cell.paybackLabel.text = "\(bills[indexPath.row].payBack).00"
        cell.stagingLabel.text = "\(bills[indexPath.row].staging)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //代码界面跳转
//        let billTableViewController = storyboard?.instantiateViewController(withIdentifier: "billTableViewControllerID") as! AddBillTableViewController
//        self.navigationController?.pushViewController(billTableViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            bills.remove(at: indexPath.row)
            
            billSaveDate()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
        
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let billToRemove = bills[fromIndexPath.row]
        bills.remove(at: fromIndexPath.row)
        bills.insert(billToRemove, at: to.row)
        
        billSaveDate()
        
        tableView.reloadData()

    }
    
    // MARK: - Navigation
    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddBillTableViewController
        ///反向传值-添加
        if segue.identifier == kaddBillSegue {
            vc.delegate = self
        } else if segue.identifier == "editSegue" {
            ///正向传值-编辑
            vc.delegate = self
            let cell = sender as! BillTableViewCell
            row = tableView.indexPath(for: cell)!.row
            vc.name = bills[row].name
            vc.payBack = bills[row].payBack
            vc.staging = bills[row].staging
        }
    }
    
    ///保存数据-本地
    func billSaveDate() {
        do {
            let data = try JSONEncoder().encode(bills)
            UserDefaults.standard.set(data, forKey: "bills")
        } catch  {
            print(error)
        }
    }
    

}

extension BillTableViewController: AddBillTableViewControllerDelegate {
    func didAddBill(name: String, payBack: String, staging: String) {
        bills.append(Bill(name: name, payBack: payBack, staging: staging))
        
        billSaveDate()
        
        tableView.insertRows(at: [IndexPath(row: bills.count - 1, section: 0)], with: .automatic)
    }
    
    func didEditBill(nameEdit: String, payBackEdit: String, stagingEdit: String) {
        bills[row].name = nameEdit
        bills[row].payBack = payBackEdit
        bills[row].staging = stagingEdit
        
        billSaveDate()
        
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! BillTableViewCell
        
        cell.billNameLabel.text = nameEdit
        cell.paybackLabel.text = payBackEdit
        cell.stagingLabel.text = stagingEdit
    }
}
