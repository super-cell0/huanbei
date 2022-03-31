//
//  HomeTableViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/6.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    let   addHomeTableViewController = AddHomeTableViewController()
    //Encodable, Decodable
    struct Home: Codable {
        //总账单
        var allBill: String
        //收入
        var income: String
        //支出
        var expenditure: String
    }
    
    var homes: [Home] = []
    var row = 0
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        //取数据
        if let data = UserDefaults.standard.data(forKey: "homes") {
            do {
                homes = try JSONDecoder().decode([Home].self, from: data)
            } catch  {
                print("解码失败",error)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "login") {
            return
        }
        let logoutViewControler = storyboard?.instantiateViewController(withIdentifier: "logoutViewControllerID") as! LogoutViewController
        self.navigationController?.pushViewController(logoutViewControler, animated: true)
    }
    
    //MARK: - Tableview datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kHomereuseIdentifier, for: indexPath) as! HomeTableViewCell
        
        cell.allBillLabel.text = "\(homes[indexPath.row].allBill).00"
        cell.incomeLabel.text = "\(homes[indexPath.row].income).00"
        cell.expenditureLabel.text = "\(homes[indexPath.row].expenditure).00"
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //         let homeTableViewControler = storyboard?.instantiateViewController(withIdentifier: "homeTableViewControllerID") as! AddHomeTableViewController
        //        self.navigationController?.pushViewController(homeTableViewControler, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //左滑删除
        if editingStyle == .delete {
            homes.remove(at: indexPath.row)
            
            saveData()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }

    ///改动数据
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        let homeToRemove = homes[fromIndexPath.row]
        homes.remove(at: fromIndexPath.row)
        homes.insert(homeToRemove, at: to.row)
        
        saveData()
        
        tableView.reloadData()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddHomeTableViewController
        if segue.identifier == kaddHomeSegue {
            vc.delegate = self
        } else if segue.identifier == "editcell" {
            vc.delegate = self
            let cell = sender as! HomeTableViewCell
            ///全局
            row = tableView.indexPath(for: cell)!.row
            vc.allBill =  homes[row].allBill
            vc.income = homes[row].income
            vc.expenditure = homes[row].expenditure
        }
    }
    
    ///保存数据
    func saveData() {
        do {
            let data = try JSONEncoder().encode(homes)
            UserDefaults.standard.set(data, forKey: "homes")
        } catch {
            print("编码错误",error)
        }
    }
    
    
}

//反向传值
extension HomeTableViewController: AddHomeTableViewControllerDelegate {
    func didAdd(allBill: String, income: String, expenditure: String) {
        ///添加数据
        homes.append(Home(allBill: allBill, income: income, expenditure: expenditure))
        //print(allBill)
        ///本地数据
        saveData()
        ///更新数据
        tableView.insertRows(at: [IndexPath(row: homes.count - 1, section: 0)], with: .automatic)
        //print(allBill, income, expenditure)
    }
    
    func didEdit(allBill: String, income: String, expenditure: String) {
        homes[row].allBill = allBill
        homes[row].income = income
        homes[row].expenditure = expenditure
        
        saveData()
        
        let indexPath = IndexPath(row: row, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! HomeTableViewCell
        cell.allBillLabel.text = homes[row].allBill
        cell.incomeLabel.text = homes[row].income
        cell.expenditureLabel.text = homes[row].expenditure
        
        //tableView.reloadData()
    }
}
