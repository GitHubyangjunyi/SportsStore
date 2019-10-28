//
//  NetworkConnection.swift
//  SportsStore
//
//  Created by 杨俊艺 on 2019/10/28.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import Foundation

class NetworkConnection {
    private let stockData: [String: Int] = [
        "Kayak" : 10,
        "Lifejacket" : 14,
        "Soccer Ball" : 32,
        "Corner Flags" : 1,
        "Stadium" : 4,
        "Thinking Cap" : 8,
        "Unsteady Chair" : 3,
        "Human Chess Board" : 2,
        "Bling-Bling King" : 4
    ]
    
    func getStockLevel(name: String) -> Int? {
        Thread.sleep(forTimeInterval: Double(5))    //虚拟网络请求的延迟5秒
        return stockData[name]
    }
}
