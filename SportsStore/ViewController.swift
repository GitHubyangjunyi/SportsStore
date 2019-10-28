//
//  ViewController.swift
//  SportsStore
//
//  Created by 杨俊艺 on 2019/9/27.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import UIKit

class ProductTableCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
    
    var product: Product?
}

class ViewController: UIViewController,UITableViewDataSource {
    
    // MARK: 关联到视图
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var productStore = ProductDataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayStockTotal()
        productStore.callback = {(p: Product) in
            for cell in self.tableView.visibleCells {
                if let pcell = cell as? ProductTableCell {
                    if pcell.product?.name == p.name {
                        pcell.stockStepper.value = Double(p.stockLevel)
                        pcell.stockField.text = String(p.stockLevel)
                    }
                }
            }
            self.displayStockTotal()
        }
    }
    
    // MARK: 实现数据源协议
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productStore.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productStore.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")as! ProductTableCell     //对象池模式和工厂方法模式
        cell.product = product
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.productDescription
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
        return cell
    }
   
    @IBAction func stockLevelDidChange(_ sender: Any) {
        if var currentCell = sender as? UIView {
            while true {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product {
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        } else if let textfield = sender as? UITextField{
                            if let newValue = Int(textfield.text ?? "") {
                                product.stockLevel = newValue
                            }
                        }
                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.stockField.text = String(product.stockLevel)
                        productLogger.logItem(item: product)
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }
    
    func displayStockTotal() {
        let finalTotals:(Int, Double) = productStore.products.reduce((0, 0.0),{(totals, product) -> (Int, Double) in return (totals.0 + product.stockLevel, totals.1 + product.stockValue)})
        //使用元组可以在reduce函数每次迭代时生成两个总量,一是库存总量,二是价值总量
        totalStockLabel.text = "\(finalTotals.0) Products in Stock." + "Total Value: \(Utils.currencyStringFromNumber(number: finalTotals.1))"
    }
    
}

