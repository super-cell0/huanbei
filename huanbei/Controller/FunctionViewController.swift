//
//  FunctionViewController.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/10.
//

import UIKit


//功能介绍
class FunctionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "功能介绍"
        self.view.backgroundColor = .white
        //navigationController?.navigationBar.prefersLargeTitles = false
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.backgroundColor = .white
        
        let textView = UITextView(frame: CGRect(x: 10, y: 0, width: view.frame.width - 20, height: view.frame.height))
        textView.backgroundColor = .white
        textView.text = "1. 快速记账随：着智能手机的出现以及移动互联网的发展，人们的支付方式也发生了巨大的改变;为了让用户可以实时了解自己的花销行为，实时记录下用户的每一笔消费                                       2. 为了让用户更直观的查看到自己的收入与支出，这一款记账APP系统整理用户的收入、支出数据                                                                                 3. 这样不仅可以为用户节约一笔不小的费用，同时还能够给用户的生活带来了极大便捷之处"
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 17,weight: .light)
        ///取消编辑内容
        textView.isEditable = false

        self.view.addSubview(scrollView)
        scrollView.addSubview(textView)

    }
    
}

