//
//  ItemCell.swift
//  ShoppingList
//
//  Created by Igor Lima on 04/05/2020.
//  Copyright © 2020 theswiftguys. All rights reserved.
//

import UIKit

protocol ChangeBox {
    func changeBox(state: Bool, index: Int?)
    func pres(imgPick: UIImagePickerController, btnImg: UIImageView!,index: Int?)
}


class ItemCell: UITableViewCell {


    @IBAction func checkBoxAction(_ sender: Any) {
        
        if items![indexP!].checked {
            delegate?.changeBox(state: false, index: indexP)
        } else {
            delegate?.changeBox(state: true, index: indexP)
        }
    }
    var imagePicker = UIImagePickerController()
    

    @IBAction func InsertImage(_ sender: Any) {
         
        imagePicker.sourceType = .photoLibrary
        imagePicker.isEditing = true
            delegate?.pres(imgPick: imagePicker, btnImg: img, index: indexP)
            
        
    }
    
    @IBOutlet weak var checkBoxOutlet: UIButton!
    
    @IBOutlet weak var ItemNameLabel: UILabel!
    
  
    @IBOutlet var img: UIImageView!
    
    
      
       var delegate: ChangeBox?
       var items: [Items]?
        var indexP: Int?
}
