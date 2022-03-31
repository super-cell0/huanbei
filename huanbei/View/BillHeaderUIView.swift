//
//  BillHeaderUIView.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/7.
//

import UIKit

class BillHeaderUIView: UIView {

    @IBOutlet weak var headerImageView: UIImageView! {
        didSet {
            headerImageView.backgroundColor = UIColor(named: "mainColor")
            headerImageView.layer.shadowColor = UIColor.lightGray.cgColor
            headerImageView.layer.shadowOffset = CGSize.zero
            headerImageView.layer.shadowOpacity = 0.5
            headerImageView.layer.shadowRadius = 5.0
            headerImageView.layer.cornerRadius = 25.0
            headerImageView.layer.masksToBounds = false
            headerImageView.layer.borderColor = UIColor.lightGray.cgColor
            headerImageView.layer.borderWidth = 0.5   
        }
    }
    //净资产
    @IBOutlet weak var netAssetLabel: UILabel! {
        didSet {
            netAssetLabel.numberOfLines = 0
        }
    }
    //总资产
    @IBOutlet weak var allAssetLabel: UILabel! {
        didSet {
            allAssetLabel.numberOfLines = 0
        }
    }
    //负债
    @IBOutlet weak var allDebtLabel: UILabel! {
        didSet {
            allDebtLabel.numberOfLines = 0
        }
    }
    

}
