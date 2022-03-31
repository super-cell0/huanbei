//
//  IconTextButton.swift
//  huanbei
//
//  Created by 贝蒂小熊 on 2022/3/10.
//

import UIKit

//button按钮可以调用的样式2
struct IconTextButtonViewModel {
    let text: String
    let image: UIImage?
    let backgroundColor: UIColor?
}

class IconTextButton: UIButton {
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .regular)
        
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(iconImageView)
        clipsToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
        if #available(iOS 13.0, *) {
            layer.borderColor = UIColor.secondarySystemBackground.cgColor
        } else {
            // Fallback on earlier versions
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: IconTextButtonViewModel) {
        label.text = viewModel.text
        backgroundColor = viewModel.backgroundColor
        iconImageView.image = viewModel.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit()
        let iconSize: CGFloat = 18
        let iconRightPadding: CGFloat = 8
        let iconX: CGFloat = (frame.size.width - label.frame.size.width - iconSize - 5) / 2
        iconImageView.frame = CGRect(x: iconX,
                                     y: (frame.size.height - iconSize) / 2,
                                     width: iconSize,
                                     height: iconSize)
        
        //如果有图片x: iconX + iconSize + 5 或者 iconX + iconSize + iconRightPadding
        label.frame = CGRect(x: iconX + iconSize - iconRightPadding,
                             y: 0,
                             width: label.frame.size.width,
                             height: frame.size.height)
    }
    
    
}

