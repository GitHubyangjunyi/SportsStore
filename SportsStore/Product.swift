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
    fileprivate var salesTaxRate: Double = 0.2

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
            return (price * (1 + salesTaxRate)) * Double(stockLevel)
        }
    }
    
    var upsells: [UpsellOpportunities] {
        get {
            return Array()
        }
    }
    
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int){
        self.name = name
        self.productDescription = description
        self.category = category
        super.init()
        self.price = price
        self.stockLevel = stockLevel
    }
    
    //工厂方法
    class func createProduct(name: String, description: String, category: String, price: Double, stockLevel: Int) -> Product {
        var productType: Product.Type
        switch category {
            case "Watersports":
                productType = WatersportsProduct.self
            case "Soccer":
                productType = SoccerProduct.self
            default:
                productType = Product.self
        }
        return productType.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
         return Product(name: self.name, description: self.description, category: self.category, price: self.price, stockLevel: self.stockLevel)
    }
    
}

enum UpsellOpportunities {
    case SwimmingLessons;
    case MapOfLakes;
    case SoccerVideos;
}

class WatersportsProduct: Product {
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int){
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        salesTaxRate = 0.10
    }
    
    override var upsells: [UpsellOpportunities] {
        return [UpsellOpportunities.SwimmingLessons, UpsellOpportunities.MapOfLakes]
    }
}

class SoccerProduct: Product {
    required init(name: String, description: String, category: String, price: Double, stockLevel: Int){
        super.init(name: name, description: description, category: category, price: price, stockLevel: stockLevel)
        salesTaxRate = 0.25
    }
    
    override var upsells: [UpsellOpportunities] {
        return [UpsellOpportunities.SoccerVideos]
    }
}

//private(set)表示同一模块中的其他文件的代码可以获取该属性值,但是只有Product.swift文件中的代码可以对其进行赋值,这里的目的是限制这些属性只能通过初始化器赋值
//fileprivate限制为只能在当前文件中访问
