//
//  AddBillTableViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/7.
//

import UIKit

protocol AddBillTableViewControllerDelegate {
    func didAddBill(name: String, payBack: String, staging: String)
    func didEditBill(nameEdit: String, payBackEdit: String, stagingEdit: String)
}

class AddBillTableViewController: UITableViewController {
    
    var delegate: AddBillTableViewControllerDelegate?
    //接收编辑文本
    var name: String?
    var payBack: String?
    var staging: String?
    //分期平台
    @IBOutlet weak var billNameTextField: UITextField! {
        didSet {
            billNameTextField.tag = 1
            billNameTextField.delegate = self
        }
    }
    
    //下单金额
    @IBOutlet weak var billNumberLaber: UITextField! {
        didSet {
            billNumberLaber.tag = 2
            billNumberLaber.delegate = self
        }
    }
    //分期数
    @IBOutlet weak var stagingTextField: UITextField! {
        didSet{
            stagingTextField.tag = 3
            stagingTextField.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        billNameTextField.becomeFirstResponder()
        billNumberLaber.keyboardType = .URL
        billNumberLaber.keyboardType = .numberPad
        stagingTextField.keyboardType = .URL
        
        billNameTextField.text = name
        billNumberLaber.text = payBack
        stagingTextField.text = staging
        
        if name != nil || payBack != nil || staging != nil {
            navigationItem.title = "编辑分期账单"
        }
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func addBillBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addBillDone(_ sender: Any) {
        if !billNameTextField.text!.isEmpty || !billNumberLaber.text!.isEmpty || !stagingTextField.text!.isEmpty {
            if name != nil || payBack != nil || staging != nil {
                delegate?.didEditBill(nameEdit: billNameTextField.text!, payBackEdit: billNumberLaber.text!, stagingEdit: stagingTextField.text!)
            } else {
                delegate?.didAddBill(name: billNameTextField.text!, payBack: billNumberLaber.text!, staging: stagingTextField.text!)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 28
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
}

extension AddBillTableViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
//        tableView.beginUpdates()
//        tableView.endUpdates()
        tableView.performBatchUpdates {
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        return true
    }
}
