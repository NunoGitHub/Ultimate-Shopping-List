//
//  AddItemController.swift
//  ShoppingList
//
//  Created by Igor Lima on 05/05/2020.
//  Copyright © 2020 theswiftguys. All rights reserved.
//

import UIKit


protocol AddItem{
    func addItem(name: String)
}

class AddItemController: UIViewController {

    @IBOutlet weak var itemNameOutlet: UITextField!
    @IBAction func addAction(_ sender: Any) {
        if itemNameOutlet.text != "" {
            
        delegate?.addItem(name: itemNameOutlet.text!)
        navigationController?.popViewController(animated: true)
            
        
    }
         }
        
    override func viewDidLoad() {
             super.viewDidLoad()

    }
    
    var delegate: AddItem?

}
