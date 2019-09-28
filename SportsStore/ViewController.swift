//
//  ViewController.swift
//  SportsStore
//
//  Created by 杨俊艺 on 2019/9/27.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayStockTotal()
    }
    // MARK: 关联到视图
    @IBOutlet weak var totalStockLabel: UILabel!
    
    var products = [
        ("Kayak", "A boat for one person", "Watersports", 275.0, 10),
        ("Lifejacket", "Protective and fashionable", "Watersports", 48.95, 14),
        ("Soccer Ball", "FIFA-approved size and weight", "Soccer", 19.5, 32),
        ("Corner Flags", "Give you playing field a professional touch", "Soccer", 34.95, 1),
        ("Stadium", "Flat-packed 35,000-seat stadium", "Soccer", 79500.0, 4),
        ("Thinking Cap", "Improve your brain efficiency by 75%", "Chess", 16.0, 8),
        ("Unsteady Chair", "Secretly give your opponent a disadvantage", "Chess", 29.95, 3),
        ("Human Chess Board", "A fun game for the family", "Chess", 75.0, 2),
        ("Bling-Bling King", "Gold-plated, diamond-studded King", "Chess", 1200.0, 4)
        ]
    
    func displayStockTotal() {
        let stockTotal = products.reduce(0, {(total, product)->Int in return total + product.4})//一开始就有闭包表达式
        totalStockLabel.text = "\(stockTotal) Products in Stock"
        
    }
}

