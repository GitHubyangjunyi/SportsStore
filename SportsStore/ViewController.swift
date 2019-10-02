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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayStockTotal()
    }
    
    // MARK: 关联到视图
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: 实现数据源协议
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")as! ProductTableCell
        cell.product = products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.descriptionLabel.text = product.description
        cell.stockStepper.value = Double(product.stockLevel)
        cell.stockField.text = String(product.stockLevel)
        return cell
    }

    // MARK: 模型
    var products = [
        Product(name: "Kayak", description: "A boat for one person", category: "Watersports", price:275.0, stockLevel:10),
        Product(name: "Lifejacket", description: "Protective and fashionable", category: "Watersports", price: 48.95, stockLevel: 14),
        Product(name: "Soccer Ball", description: "FIFA-approved size and weight", category: "Soccer", price: 19.5, stockLevel: 32),
        Product(name: "Corner Flags", description: "Give you playing field a professional touch", category: "Soccer", price: 34.95, stockLevel: 1),
        Product(name: "Stadium", description: "Flat-packed 35,000-seat stadium", category: "Soccer", price: 79500.0, stockLevel: 4),
        Product(name: "Thinking Cap", description: "Improve your brain efficiency by 75%", category: "Chess", price: 16.0, stockLevel: 8),
        Product(name: "Unsteady Chair", description: "Secretly give your opponent a disadvantage", category: "Chess", price: 29.95, stockLevel: 3),
        Product(name: "Human Chess Board", description: "A fun game for the family", category: "Chess", price: 75.0, stockLevel: 2),
        Product(name: "Bling-Bling King", description: "Gold-plated, diamond-studded King", category: "Chess", price: 1200.0, stockLevel: 4)
        ]
    
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
                    }
                    break
                }
            }
            displayStockTotal()
        }
    }
    
    func displayStockTotal() {
        let finalTotals:(Int, Double) = products.reduce((0, 0.0),{(totals, product) -> (Int, Double) in return (totals.0 + product.stockLevel, totals.1 + product.stockValue)})//一开始就有闭包表达式
        //使用元组可以在reduce函数每次迭代时生成两个总量,一是库存总量,二是价值总量
        totalStockLabel.text = "\(finalTotals.0) Products in Stock." + "Total Value: \(Utils.currencyStringFromNumber(number: finalTotals.1))"
    }
}

