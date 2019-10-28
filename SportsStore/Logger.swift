//
//  Logger.swift
//  SportsStore
//
//  Created by 杨俊艺 on 2019/10/3.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import Foundation

let productLogger = Logger<Product>(callback: {p in print("Change: \(p.name) \(p.stockLevel) items in stock")//全局单例对象
})

final class Logger<T> where T: NSObject, T: NSCopying{
    var dataItems:[T] = []
    var callback:(T) -> Void
    var arrayQ = DispatchQueue.init(label: "arrayQ", attributes: [.concurrent])     //操作数组的并行队列
    var callbackQ = DispatchQueue(label: "callbackQ")                               //操作回调的串行队列
    
    fileprivate init(callback: @escaping (T) -> Void, protect:Bool = true) {
        self.callback = callback
        if protect {
            self.callback = {(item: T) in
                self.callbackQ.sync(execute: {() in callback(item)})
            }
        }
    }
    
    func logItem(item: T) {
        arrayQ.async(group: nil, qos: .default, flags: [.barrier], execute: {() in  //当某个barrier block队列到达最前端时将会等待前面所有正在进行的读取操作完成
            self.dataItems.append(item.copy() as! T)                                //读取操作完成后才会进行写操作并且在写操作完成之前不会处理任何后续的blcok
            self.callback(item)
        })
        
    }
    
    func processItems(callback: @escaping (T) -> Void) {
        arrayQ.sync(execute: {() in                                                 //block运行完成之后该方法才会返回
            for item in dataItems {
                callback(item)
            }
        })
    }
    
}
