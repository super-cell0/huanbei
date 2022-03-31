//
//  ConnectViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/10.
//

import UIKit

//联系我们
class ConnectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "联系我们"
        //navigationController?.navigationBar.prefersLargeTitles = false
        self.view.backgroundColor = .white
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.view.addSubview(scrollView)
        
        let twoLineButton = TwoLineButton(frame: CGRect(x: 10, y: 20, width: view.frame.width - 20, height: 55 ))
        scrollView.addSubview(twoLineButton)
        //twoLineButton.center = view.center
        twoLineButton.configure(with: TwoLineButtonViewModel(primaryText: "4453-2123-131", secondaryText: "联系客服"))
        
        twoLineButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        // 拨打电话
         let phone = "telprompt://" + "4453-2123-131"
         if UIApplication.shared.canOpenURL(URL(string: phone)!) {
             UIApplication.shared.open(URL(string: phone)!, options: [:], completionHandler: nil)
          }
        
    }

}
