//
//  GCDSection.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/8.
//

import Foundation

enum GCDSection: CaseIterable {
    case primary
    case advanced
    
    var title: String? {
        switch self {
        case .primary:
            return "初级"
        case .advanced:
            return "进阶"
        }
    }
    
    var rows: [GCDRow] {
        switch self {
        case .primary:
            return [.syncSerialQueue, .syncConcurrentQueue, .asyncSerialQueue, .asyncConcurrentQueue]
        case .advanced:
            return [.dispatchGroup, .barrier]
        }
    }
}

enum GCDRow {
    case syncSerialQueue
    case syncConcurrentQueue
    case asyncSerialQueue
    case asyncConcurrentQueue
    case dispatchGroup
    case barrier
    
    var title: String {
        switch self {
        case .syncSerialQueue:
            return "同步串行队列"
        case .syncConcurrentQueue:
            return "同步并发队列"
        case .asyncSerialQueue:
            return "异步串行队列"
        case .asyncConcurrentQueue:
            return "异步并发队列"
        case .dispatchGroup:
            return "Dispatch Group"
        case .barrier:
            return "DispatchWorkItem barrier"
        }
    }
}
