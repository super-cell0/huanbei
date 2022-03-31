//
//  addBorrowViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/13.
//

import UIKit

protocol addBorrowViewControllerDelegate {
    func didAdd(name: String)
    func didEdit(nameEdit: String)
}

class addBorrowViewController: UIViewController {
    
    @IBOutlet weak var addBorrowTextField: UITextView!
    
    var delegate: addBorrowViewControllerDelegate?
    
    var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()

//        addBorrowTextField.delegate = self
        addBorrowTextField.becomeFirstResponder()
        addBorrowTextField.text = name
        
        if name != nil {
            navigationItem.title = "编辑"
        }
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func addBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func addDone(_ sender: Any) {
        if !addBorrowTextField.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if name != nil {
                delegate?.didEdit(nameEdit: addBorrowTextField.text)
            } else {
                delegate?.didAdd(name: addBorrowTextField.text)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

