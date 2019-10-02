//
//  Utils.swift
//  SportsStore
//
//  Created by 杨俊艺 on 2019/10/2.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import Foundation

class Utils{
    
    class func currencyStringFromNumber(number:Double)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
