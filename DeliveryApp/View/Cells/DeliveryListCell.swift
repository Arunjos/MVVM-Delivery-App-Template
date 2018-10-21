//
//  DeliveryListCell.swift
//  DeliveryApp
//
//  Created by Arun Jose on 19/10/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import UIKit

class DeliveryListCell: UITableViewCell {
    let deliveryImageView = UIImageView()
    let deliveryDescriptionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(deliveryImageView)
        contentView.addSubview(deliveryDescriptionLabel)
        
        deliveryImageView.snp.makeConstraints{(make) -> () in
            make.top.equalTo(contentView).offset(5)
            make.leading.equalTo(contentView).offset(0)
            make.bottom.equalTo(contentView).offset(-5)
            make.width.equalTo(deliveryImageView.snp.height).multipliedBy(1)
        }
        deliveryDescriptionLabel.snp.makeConstraints{(make) -> () in
            make.top.equalTo(contentView).offset(5)
            make.leading.equalTo(deliveryImageView.snp.trailing).offset(10)
            make.bottom.equalTo(contentView).offset(-5)
            make.trailing.equalTo(contentView).offset(0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
