//
//  HomeHeaderView.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/14.
//

import UIKit

class HomeHeaderView: UIView {

    @IBOutlet weak var homeImageView: UIImageView! {
        didSet {
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

}
