//
//  ListViewCell.swift
//  OpenMarket
//
//  Created by iluxsm on 2021/01/29.
//

import UIKit

class ListViewCell: UITableViewCell {

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemStock: UILabel!
    @IBOutlet weak var discountedItemPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // itemName
        self.itemName.font = UIFont.systemFont(ofSize: 17)
        // itemPrice
        self.itemPrice.font = UIFont.systemFont(ofSize: 14.5)
        self.itemPrice.textColor = UIColor.lightGray
        // discountedPrice
        self.discountedItemPrice.font = UIFont.systemFont(ofSize: 14.5)
        self.discountedItemPrice.textColor = UIColor.lightGray
        // itemStock
        self.itemStock.font = UIFont.systemFont(ofSize: 14.5)
        self.itemStock.textColor = UIColor.lightGray
    }
}
