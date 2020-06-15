//
//  ShoppingCell.swift
//  ShoppingList
//
//  Created by NunoPereira on 11/05/2020.
//  Copyright © 2020 theswiftguys. All rights reserved.
//

import UIKit

class ShoppingCell: UITableViewCell {//video cell

    @IBOutlet weak var nameList: UILabel!
    
    func setShopping(item : ShoppingItem) {
        nameList.text = item.title
    }
    

}
