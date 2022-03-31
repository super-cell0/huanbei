//
//  PrivacyViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/10.
//

import UIKit
import WebKit
import SafariServices

//隐私政策
class PrivacyViewController: UIViewController {

    var targetURL = "https://www.apple.com"
    var webView = WKWebView()
    var scrolleView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "隐私政策"
        self.view.backgroundColor = .white
        self.view.addSubview(scrolleView)
        scrolleView.addSubview(webView)
        
        guard let url = URL(string: targetURL) else {
            return
        }
        webView.load(URLRequest(url: url))
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrolleView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.size.height)
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
    }
    

}


