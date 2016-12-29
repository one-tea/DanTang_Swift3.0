//
//  SearchCell.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/14.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.headImageView.layer.cornerRadius = 10;
        self.headImageView.layer.masksToBounds = true;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
