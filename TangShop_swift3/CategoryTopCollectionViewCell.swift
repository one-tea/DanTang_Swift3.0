//
//  CategoryTopCollectionViewCell.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/26.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit

class CategoryTopCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.backgroundColor = UIColor.white
		imageView.layer.cornerRadius = 7.0
		imageView.layer.masksToBounds = true
    }

}
