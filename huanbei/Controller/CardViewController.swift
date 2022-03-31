//
//  CardViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/13.
//

import UIKit

protocol CardViewControllerDelegate {
    func didAdd(bank: String, number: String)
}

class CardViewController: UIViewController {
    
    var delegate: CardViewControllerDelegate?

    @IBOutlet weak var nemeTextField: UITextField!
    @IBOutlet weak var bankTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nemeTextField.becomeFirstResponder()
        numberTextField.keyboardType = .numberPad
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func addback(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addDone(_ sender: Any) {
        if !nemeTextField.text!.isEmpty || !bankTextField.text!.isEmpty || !numberTextField.text!.isEmpty {
            delegate?.didAdd(bank: bankTextField.text!, number: numberTextField.text!)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
