//
//  BillTableViewCell.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/7.
//

import UIKit

class BillTableViewCell: UITableViewCell {
    
    @IBOutlet weak var billImageView: UIImageView! {
        didSet {
            billImageView.backgroundColor = UIColor(named: "mainColor")
            billImageView.layer.shadowColor = UIColor.lightGray.cgColor
            billImageView.layer.shadowOffset = CGSize.zero
            billImageView.layer.shadowOpacity = 0.5
            billImageView.layer.shadowRadius = 3.0
            billImageView.layer.cornerRadius = 20.0
            billImageView.layer.masksToBounds = false
            billImageView.layer.borderColor = UIColor.lightGray.cgColor
            billImageView.layer.borderWidth = 0.5
        }
    }
    //分期平台名称
    @IBOutlet weak var billNameLabel: UILabel! {
        didSet {
            billNameLabel.numberOfLines = 0
        }
    }
    //应还总额
    @IBOutlet weak var paybackLabel: UILabel!
    //分期数
    @IBOutlet weak var stagingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
