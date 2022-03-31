//
//  MyViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/8.
//

import UIKit

class MyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var titleName = ["功能介绍","隐私政策","联系我们"]
    
    @IBOutlet weak var myImageView: UIImageView! {
        didSet {
            myImageView.layer.shadowColor = UIColor.lightGray.cgColor
            myImageView.layer.shadowOffset = CGSize.zero
            myImageView.layer.shadowOpacity = 0.5
            myImageView.layer.shadowRadius = 3.0
            myImageView.layer.cornerRadius = 10.0
            myImageView.layer.masksToBounds = false
            myImageView.layer.borderColor = UIColor.lightGray.cgColor
            myImageView.layer.borderWidth = 0.2
        }
    }
    //昵称
    @IBOutlet weak var myNameLabel: UILabel!
    //账号
    @IBOutlet weak var myaccountLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    //功能介绍
    let functionViewController = FunctionViewController()
    //隐私政策
    let privacyViewVController = PrivacyViewController()
    //联系我们
    let connectViewController = ConnectViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        myaccountLabel.text = "hbid_kjacc\(UserDefaults.standard.object(forKey: "code") as? String ?? "_")"
        myNameLabel.text = UserDefaults.standard.object(forKey: "phoneName") as? String
        
        //print(NSHomeDirectory())
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kMyIdentifier, for: indexPath)
        if #available(iOS 14.0, *) {
            var contentConfigure = cell.defaultContentConfiguration()
            
            contentConfigure.text = titleName[indexPath.row]
            cell.contentConfiguration = contentConfigure
            cell.selectionStyle = .blue
        } else {
            // Fallback on earlier versions
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            self.functionViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(functionViewController, animated: true)
        case 1:
            self.privacyViewVController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(privacyViewVController, animated: true)
        case 2:
            self.connectViewController.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(connectViewController, animated: true)
        default:
            fatalError("无法传送界面")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "logoutSegue" {
            let vc = segue.destination as! LogoutViewController
            vc.delegate = self
        }
    }

    
}

extension MyViewController: LogoutViewControllerDelegate {
    func didAdd(phoneName: String, code: String) {
        myNameLabel.text = phoneName
        myaccountLabel.text = "hbid_kjacc\(code.suffix(3))"
        
        UserDefaults.standard.setValue(phoneName, forKey: "phoneName")
        UserDefaults.standard.setValue(code.suffix(_:3), forKey: "code")
    }

}
    


