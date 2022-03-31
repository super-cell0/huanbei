//
//  AddLendTableViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/13.
//

import UIKit

protocol AddLendTableViewControllerDelegate {
    func didAdd(lendName: String)
    func didEdit(lendNameEdit: String)
}

class AddLendTableViewController: UITableViewController {

    var delegate: AddLendTableViewControllerDelegate?
    var editLendName: String?
    
    @IBOutlet weak var lendNameTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lendNameTextField.delegate = self
        lendNameTextField.becomeFirstResponder()
        lendNameTextField.text = editLendName
        
        if editLendName != nil {
            navigationItem.title = "编辑"
        }
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }

    @IBAction func lendBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func lendDone(_ sender: Any) {
        if !lendNameTextField.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if editLendName != nil {
                delegate?.didEdit(lendNameEdit: lendNameTextField.text)
            } else {
                delegate?.didAdd(lendName: lendNameTextField.text)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension AddLendTableViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if #available(iOS 11.0, *) {
            tableView.performBatchUpdates {
                
            }
        } else {
            // Fallback on earlier versions
        }

    }
}
