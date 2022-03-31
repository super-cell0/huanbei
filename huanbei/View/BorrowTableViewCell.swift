//
//  BorrowTableViewCell.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/13.
//

import UIKit

class BorrowTableViewCell: UITableViewCell {

    @IBOutlet weak var checkButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        if #available(iOS 13.0, *) {
            checkButton.setImage(UIImage(systemName: "circle"), for: .normal)
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 13.0, *) {
            checkButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
        } else {
            // Fallback on earlier versions
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
