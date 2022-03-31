//
//  AddHomeTableViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/7.
//

import UIKit

protocol AddHomeTableViewControllerDelegate {
    func didAdd(allBill: String, income: String, expenditure: String)
    func didEdit(allBill: String, income: String, expenditure: String)
}

class AddHomeTableViewController: UITableViewController {
    
    var delegate: AddHomeTableViewControllerDelegate?
    
    //接收编辑的文本
    var allBill: String?
    var income: String?
    var expenditure: String?
    
    @IBOutlet weak var addAllBillTextField: UITextField! {
        didSet {
            addAllBillTextField.delegate = self
            addAllBillTextField.tag = 1
        }
    }
    @IBOutlet weak var addIncomeTextField: UITextField! {
        didSet {
            addIncomeTextField.delegate = self
            addIncomeTextField.tag = 2
        }
    }
    @IBOutlet weak var addExpenditureTextField: UITextField! {
        didSet {
            addExpenditureTextField.delegate = self
            addExpenditureTextField.tag = 3
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        addAllBillTextField.becomeFirstResponder()
        addAllBillTextField.keyboardType = .numberPad
        addIncomeTextField.keyboardType = .numberPad
        addExpenditureTextField.keyboardType = .numberPad
        
        addAllBillTextField.text = allBill
        addIncomeTextField.text = income
        addExpenditureTextField.text = expenditure
        
        if allBill != nil || income != nil || expenditure != nil {
            navigationItem.title = "编辑账单"
        }
        
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func addBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addDone(_ sender: Any) {
        if !addAllBillTextField.text!.isEmpty || !addIncomeTextField.text!.isEmpty || !addExpenditureTextField.text!.isEmpty {
            if allBill != nil || income != nil || expenditure != nil {
                delegate?.didEdit(allBill: addAllBillTextField.text!, income: addIncomeTextField.text!, expenditure: addExpenditureTextField.text!)
            } else {
                delegate?.didAdd(allBill: addAllBillTextField.text!, income: addIncomeTextField.text!, expenditure: addExpenditureTextField.text!)
            }
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

extension AddHomeTableViewController: UITextFieldDelegate {
    //高度实时刷新
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
