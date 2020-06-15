//
//  ViewController.swift
//  ShoppingList
//
//  Created by Igor Lima on 04/05/2020.
//  Copyright © 2020 theswiftguys. All rights reserved.
//

import UIKit

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, AddItem , ChangeBox, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
   
    @IBOutlet weak var ShoppingTableView: UITableView!
    
    @IBOutlet weak var shoppingListTextField: UITextField!
    
    var lastIndexSelected : IndexPath = []
    
    var shoppingList : [ShoppingItem] = []
    
    var isSelecting : Bool = false
    
    var itemCpy : [Items] = []
    
    var items: [Items] = []
    
    @IBAction func shoppingListButton(_ sender: Any) {
        InsertShoppingItem()
    }
    func InsertShoppingItem() {
        if(shoppingListTextField.text! != ""){
        shoppingList.append(ShoppingItem(title: shoppingListTextField.text! ))
       
        let indexPath = IndexPath(row: shoppingList.count-1, section: 0)
        ShoppingTableView.beginUpdates()
        ShoppingTableView.insertRows(at: [indexPath], with: .automatic)
        ShoppingTableView.endUpdates()
        shoppingListTextField.text = ""
        view.endEditing(true)
          //adiciona os item há shopping list quando insiro itemsShoping list
        for shopp in shoppingList{
                   
                   if(itemCpy.count-1 > shopp.itemCpy.count-1){
                   for (index,itemAux) in itemCpy.enumerated() {
                       if(index>shopp.itemCpy.count-1)  {
                           shopp.itemCpy.append(Items(name: itemAux.name, cheked: itemAux.checked))
                           }
                       }
                   }
               }
        }
    }
  
    
    func changeBox(state: Bool, index: Int?) {
        items[index!].checked = state
        tableView.reloadRows(at: [IndexPath(row: index!, section: 0)],with: UITableView.RowAnimation.none)
        //update in
        if(isSelecting){
            shoppingList[lastIndexSelected.row].itemCpy[index!].checked = state
          UpdateCheckerCells()
         
        }
      
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShoppingTableView.tableFooterView = UIView(frame: CGRect.zero)
        ShoppingTableView.delegate = self
        ShoppingTableView.dataSource = self
        
    }
    
     func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {

        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {

            let touchPoint = longPressGestureRecognizer.location(in: self.ShoppingTableView)
            if let indexPath = ShoppingTableView.indexPathForRow(at: touchPoint) {

                // your code here, get the row for the indexPath or do whatever you want
              
               let cells = ShoppingTableView.cellForRow(at: indexPath) as! ShoppingCell
                if(cells.backgroundColor == UIColor .blue){
                    cells.backgroundColor = UIColor .white
                    lastIndexSelected = []
                    isSelecting = false
                    //tira o check quando faço o deselect
                      for  (indexAux,itemCp) in shoppingList[indexPath.row].itemCpy.enumerated(){
                             //   var cell =  tableView.visibleCells as! Array<UITableViewCell>
                           if(isSelecting == false){
                            if(items.count  <= indexAux ){
                                items[indexAux-1].checked = false
                             }else{
                                items[indexAux].checked = false
                                 }
                           }
                          
                                tableView.reloadData()
                           }
            
                }
                else{
                    //se nenhuma célula for selecionada
                    if(indexPath != lastIndexSelected){
                        let cells1 = ShoppingTableView.visibleCells as! Array<UITableViewCell>
                        
                        for cell in cells1 {
                            if(cells != cell){
                                cell.backgroundColor = UIColor .white
                               // UpdateCheckerCells()
                            }
                             
                        }
                    }
                isSelecting = true
                cells.backgroundColor = UIColor .blue
                lastIndexSelected = indexPath
                    //faz o update do check
                    UpdateCheckerCells()
                    
                     }
                 }
        }
    }
    //faz update ao check quando existe uma seleç\ao
    func UpdateCheckerCells(){
        for  (indexAux,itemCp) in shoppingList[lastIndexSelected.row].itemCpy.enumerated(){
           //   var cell =  tableView.visibleCells as! Array<UITableViewCell>
         if(itemCp.checked == true){
              items[indexAux].checked = itemCp.checked
         }else if(indexAux < items.count){
               items[indexAux].checked = false
         }
        
              tableView.reloadData()
         }
    }
    
    @IBAction func longPressShoppTable(_ sender: UILongPressGestureRecognizer) {
        longPress(longPressGestureRecognizer: sender)
    }

    var btnImage : UIImageView!
    var indexImage = Int?(0)
    
  func pres(imgPick: UIImagePickerController, btnImg: UIImageView!,index: Int?) {
    imgPick.delegate = self
    indexImage = index
       present(imgPick, animated: true, completion: nil)


   }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //btnImage.image = image
            items[indexImage!].btnImage  = UIImageView( image: image)
                
            }
            dismiss(animated: true, completion: nil)
         tableView.reloadRows(at: [IndexPath(row: indexImage!, section: 0)],with: UITableView.RowAnimation.none)
          
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == ShoppingTableView){
            return shoppingList.count
        }
        else{
            return items.count
        }
          
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if (tableView == ShoppingTableView){
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellShop", for: indexPath) as! ShoppingCell
            let item = shoppingList[indexPath.row]
            cell.setShopping(item: item)
            cell.selectionStyle = .none
            return cell
            
       }
        else{
            
      let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCell
        
        cell.ItemNameLabel.text = items[indexPath.row].name
     
            if(items[indexPath.row].btnImage != nil){
                
            cell.img.image = items[indexPath.row].btnImage.image
                }
            if(items[indexPath.row].btnImage == nil){
                cell.img = UIImageView(image: UIImage(systemName: "square.and.arrow.up"))
                
            }

       
        
        if items[indexPath.row].checked {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxFILLED "), for: UIControl.State.normal)
        } else {
            cell.checkBoxOutlet.setBackgroundImage(#imageLiteral(resourceName: "checkBoxOUTLINE "), for: UIControl.State.normal)
        }
        
       cell.delegate = self
       cell.items = items
       cell.indexP = indexPath.row
        
        return cell
            }
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (tableView == ShoppingTableView){
            if editingStyle == .delete {
                shoppingList.remove(at: indexPath.row)
                ShoppingTableView.beginUpdates()
                ShoppingTableView.deleteRows(at: [indexPath], with: .automatic)
                ShoppingTableView.endUpdates()
            }
        }
        else{
            if editingStyle == .delete {
                           items.remove(at: indexPath.row)
                           tableView.beginUpdates()
                           tableView.deleteRows(at: [indexPath], with: .automatic)
                           tableView.endUpdates()
                           itemCpy.remove(at: indexPath.row)
                            for shopp in shoppingList{
                                shopp.itemCpy.remove(at: indexPath.row)
                                
                            }
                       }
            
        }
                   
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddItemController
        vc.delegate = self
    }
    var indexAux : Int = 0
    func addItem(name: String) {
     items.append(Items(name: name, cheked: false))
    tableView.reloadData()

        items[items.count-1].btnImage = UIImageView(image: UIImage(systemName: "square.and.arrow.up"))

            
       
        //adiciona todos os items da lista ao shopping list
 
        //adiciona os item há shopping list quando indsiro items
        itemCpy.append(Items(name: name, cheked: false))
        for shopp in shoppingList{
            
            if(itemCpy.count-1 > shopp.itemCpy.count-1){
            for (index,itemAux) in itemCpy.enumerated() {
                if(index>shopp.itemCpy.count-1)  {
                    shopp.itemCpy.append(Items(name: itemAux.name, cheked: itemAux.checked))
                    }
                }
            }
        }
    }
    
}

class Items {
var name = ""
var checked = false
var btnImage : UIImageView!

    convenience init (name: String, cheked : Bool) {
    self.init()
    self.name = name
    self.checked = cheked
}
}


