//
//  Product.swift
//  SportsStore
//
//  Created by 杨俊艺 on 2019/10/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import Foundation

class Product: NSObject, NSCopying{
    
    private(set) var name:String
    private(set) var productDescription:String
    private(set) var category:String
    private var stockLevelBackingValue:Int = 0
    private var priceBackingValue:Double = 0

    private(set) var price:Double{
        get{
            return priceBackingValue
        }
        set{
            priceBackingValue = max(1, newValue)
        }
    }
    
    var stockLevel:Int{
        get{
            return stockLevelBackingValue
        }
        set{
            stockLevelBackingValue = max(0, newValue)
        }
    }
    
    var stockValue:Double{
        get{
            return price * Double(stockLevel)
        }
    }
    
    init(name:String, description:String, category:String, price:Double, stockLevel:Int) {
        self.name = name
        self.productDescription = description
        self.category = category
        
        super.init()
        
        self.price = price
        self.stockLevel = stockLevel
    }

    func copyWithZone(zone: NSZone) -> AnyObject {
        return Product(name: self.name, description: self.description, category: self.category, price: self.price, stockLevel: self.stockLevel)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
         return Product(name: self.name, description: self.description, category: self.category, price: self.price, stockLevel: self.stockLevel)
    }
    
}

//private(set)表示同一模块中的其他文件的代码可以获取该属性值,但是只有Product.swift文件中的代码可以对其进行赋值,这里的目的是限制这些属性只能通过初始化器赋值
//private限制为只能在当前文件中访问
