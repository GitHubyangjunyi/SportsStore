//
//  NetworkPool.swift
//  SportsStore
//
//  Created by 杨俊艺 on 2019/10/28.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import Foundation

//管理多个NetworkConnection对象的单例模式对象池
final class NetworkPool {
    private let connectionCount = 3
    private var connections = [NetworkConnection]()
    private var semaphore: DispatchSemaphore
    private var queue: DispatchQueue
    private var itemsCreated = 0
    
    private init() {
        semaphore = DispatchSemaphore(value: connectionCount)
        queue = DispatchQueue(label: "networkpoolQ")
    }
    
    private func doGetConnection() -> NetworkConnection {
        semaphore.wait()
        var result: NetworkConnection? = nil
        queue.sync(execute: {() in
            if self.connections.count > 0 {
                result = self.connections.remove(at: 0)
            } else if self.itemsCreated < self.connectionCount {
                result = NetworkConnection()
                self.itemsCreated += 1
            }
        })
        return result!
    }
    
    private func doReturnConnection(conn: NetworkConnection) {
        queue.async(execute: {() in
            self.connections.append(conn)
            self.semaphore.signal()
        })
    }
    
    class func getConnection() -> NetworkConnection {
        return sharedInstance.doGetConnection()
    }
    
    class func returnConnection(conn: NetworkConnection) {
        sharedInstance.doReturnConnection(conn: conn)
    }
    
    private class var sharedInstance: NetworkPool {
        get {
            struct SingletonWrapper {
                static let singleton = NetworkPool()
            }
            return SingletonWrapper.singleton
        }
    }
    
}
