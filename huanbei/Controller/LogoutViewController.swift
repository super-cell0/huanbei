//
//  LogoutViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/10.
//

import UIKit

//登录/退出界面

protocol LogoutViewControllerDelegate {
    func didAdd(phoneName: String, code: String)
}

class LogoutViewController: UIViewController{
    
    var delegate: LogoutViewControllerDelegate?
    
    ///电话号码
    @IBOutlet weak var phoneTextField: UITextField! {
        didSet {
            phoneTextField.delegate=self
        }
    }
    ///验证码
    @IBOutlet weak var phoneCode: UITextField! {
        didSet {
            phoneCode.delegate=self
        }
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        phoneTextField.becomeFirstResponder()
        phoneTextField.keyboardType = .numberPad
        //navigationItem.leftBarButtonItem = .none

        title = "欢迎使用"
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

    }
    
//    @IBAction func back(_ sender: Any) {
//
//        navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func done(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "login")
        
        if !phoneTextField.text!.isEmpty || !phoneCode.text!.isEmpty {
            delegate?.didAdd(phoneName: phoneTextField.text!, code: phoneCode.text!)
        }
        
//        UserDefaults.standard.set(phoneTextField, forKey: "phoneTextField")
//        UserDefaults.standard.set(phoneCode, forKey: "phoneCode")
        
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension LogoutViewController: UITextFieldDelegate {
    
}
