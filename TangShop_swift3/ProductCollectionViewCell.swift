//
//  ProductCollectionViewCell.swift
//  TangShop_swift3
//
//  Created by Kevin on 16/10/24.
//  Copyright © 2016年 zhangkk. All rights reserved.
//

import UIKit
import SwiftyJSON
import SDWebImage
class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageVeiw: UIImageView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var likeBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        self.layer.cornerRadius=5
        self.layer.masksToBounds=true
        self.backgroundColor = UIColor.white
        
    }
    //MERK:  - as
   public func setCellWithModel(model:ProductMoel) -> Void {
        imageVeiw.sd_setImage(with:URL.init(string: model.coverImageUrl), placeholderImage: nil)
        titleL.text = model.name
        priceL.text = model.price
        likeBtn.setTitle(String( model.favoritesCount), for: UIControlState())
        
    }

}
