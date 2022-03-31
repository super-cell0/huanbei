//
//  HomeTableViewCell.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/6.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var homeImageView: UIImageView! {
        didSet {
            homeImageView.backgroundColor = UIColor(named: "mainColor")
            homeImageView.layer.shadowColor = UIColor.lightGray.cgColor
            homeImageView.layer.shadowOffset = CGSize.zero
            homeImageView.layer.shadowOpacity = 0.5
            homeImageView.layer.shadowRadius = 3.0
            homeImageView.layer.cornerRadius = 20.0
            homeImageView.layer.masksToBounds = true
            homeImageView.layer.borderColor = UIColor.lightGray.cgColor
            homeImageView.layer.borderWidth = 0.5
        }
    }
    
    @IBOutlet weak var allBillLabel: UILabel!
    @IBOutlet weak var incomeLabel: UILabel!
    @IBOutlet weak var expenditureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
