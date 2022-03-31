//
//  TwoLineButton.swift
//  huanbei
//  Created by 贝蒂小熊 on 2022/3/10.
//

import UIKit

//button按钮可以掉用的样式1
struct TwoLineButtonViewModel {
    //title
    let primaryText: String
    //subtitle
    let secondaryText: String
}

class TwoLineButton: UIButton {
    private let primaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 25, weight: .regular)
        
        return label
    }()
    
    private let secondaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .systemBlue
        label.font = .systemFont(ofSize: 17, weight: .thin)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            layer.borderColor = UIColor.secondarySystemBackground.cgColor
        } else {
            // Fallback on earlier versions
        }
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TwoLineButtonViewModel) {
        primaryLabel.text = viewModel.primaryText
        secondaryLabel.text = viewModel.secondaryText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        primaryLabel.frame = CGRect(x: 0,
                                    y: 0,
                                    width: frame.size.width,
                                    height: frame.size.height / 2)
        secondaryLabel.frame = CGRect(x: 0,
                                      y: frame.size.height / 2,
                                      width: frame.size.width,
                                      height: frame.size.height / 2)
    }

    
}
