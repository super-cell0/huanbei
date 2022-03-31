//
//  CardTableViewCell.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/13.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var cardImageView: UIImageView! {
        didSet {
            cardImageView.backgroundColor = UIColor(named: "mainColor")
            cardImageView.layer.cornerRadius = 5
            cardImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
