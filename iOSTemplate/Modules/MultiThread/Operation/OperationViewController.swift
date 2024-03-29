//
//  OperationViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/8.
//

import UIKit

class OperationViewController: ListViewController {
    
    let viewModel = OperationViewModel()
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "初级", rowItems: [
                ListRowItem(title: "简单使用", tapAction: { [weak self] in
                    self?.simple()
                }),
                ListRowItem(title: "最大并发数", tapAction: { [weak self] in
                    self?.maxCount()
                }),
                ListRowItem(title: "栅栏", tapAction: { [weak self] in
                    self?.barrier()
                }),
                ListRowItem(title: "依赖", tapAction: { [weak self] in
                    self?.dependency()
                }),
                ListRowItem(title: "自定义 Operation", tapAction: { [weak self] in
                    self?.customOperation()
                })
                
            ]),
            ListSectionItem(title: "实操", rowItems: [
                ListRowItem(title: "下载器", tapAction: { [weak self] in
                    self?.downloader()
                })
            ])
        ]
    }

}

// MARK: - 初级
extension OperationViewController {
    /// 一个简单的操作队列示例
    ///
    /// Operation是对任务的封装，便于监控和管理任务的状态。
    /// Operation 可以单独执行，也可以添加到队列中执行。
    /// Operation 添加到队列之后，会被自动执行。
    private func simple() {
        Logger.info("begin")
        
        let operationQueue = OperationQueue()
        
        // Operation1
        let operation1 = BlockOperation {
            Logger.info("Operation1 begin")
            Logger.info("Operation1 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Operation1 end")
        }
        
        // Operation2
        let operation2 = BlockOperation {
            Logger.info("Operation2 begin")
            Logger.info("Operation2 thread: \(Thread.current)")
            sleep(2)
            Logger.info("Operation2 end")
        }
        
        // Operation3
        let operation3 = BlockOperation {
            Logger.info("Operation3 begin")
            Logger.info("Operation3 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Operation3 end")
        }
        
        Logger.info("Add Operation1")
        operationQueue.addOperation(operation1)

        Logger.info("Add Operation2")
        operationQueue.addOperation(operation2)

        Logger.info("Add Operation3")
        operationQueue.addOperation(operation3)
        
        Logger.info("end")
    }
    
    /// 设置最大并发数
    ///
    /// OperationQueue 可以设置队列的最大并发数。
    /// 当任务入列时，若正在运行的任务数超过最大任务数，则当前任务会进入等待状态，排队等待其他任务完成之后再执行。
    private func maxCount() {
        Logger.info("begin")
        
        let operationQueue = OperationQueue()
        operationQueue.maxConcurrentOperationCount = 2
        
        // Operation1
        let operation1 = BlockOperation {
            Logger.info("Operation1 begin")
            Logger.info("Operation1 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Operation1 end")
        }
        
        // Operation2
        let operation2 = BlockOperation {
            Logger.info("Operation2 begin")
            Logger.info("Operation2 thread: \(Thread.current)")
            sleep(2)
            Logger.info("Operation2 end")
        }
        
        // Operation3
        let operation3 = BlockOperation {
            Logger.info("Operation3 begin")
            Logger.info("Operation3 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Operation3 end")
        }
        
        Logger.info("Add Operation1")
        operationQueue.addOperation(operation1)
        
        Logger.info("Add Operation2")
        operationQueue.addOperation(operation2)
        
        Logger.info("Add Operation3")
        operationQueue.addOperation(operation3)
        
        Logger.info("end")
    }
    
    /// 栅栏
    ///
    /// 同 GCD barrier。barrier 中的任务会将其之前和之后的任务分隔开。
    private func barrier() {
        Logger.info("begin")
        
        let operationQueue = OperationQueue()
        
        // Operation1
        let operation1 = BlockOperation {
            Logger.info("Operation1 begin")
            Logger.info("Operation1 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Operation1 end")
        }
        
        // Operation2
        let operation2 = BlockOperation {
            Logger.info("Operation2 begin")
            Logger.info("Operation2 thread: \(Thread.current)")
            sleep(2)
            Logger.info("Operation2 end")
        }
        
        // Operation3
        let operation3 = BlockOperation {
            Logger.info("Operation3 begin")
            Logger.info("Operation3 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Operation3 end")
        }
        
        Logger.info("Add Operation1")
        operationQueue.addOperation(operation1)
        
        Logger.info("Add Operation2")
        operationQueue.addOperation(operation2)
        
        if #available(iOS 13.0, *) {
            operationQueue.addBarrierBlock {
                Logger.info("Barrier begin")
                Logger.info("Barrier thread: \(Thread.current)")
                sleep(1)
                Logger.info("Barrier end")
            }
        } else {
            // Fallback on earlier versions
        }
        
        Logger.info("Add Operation3")
        operationQueue.addOperation(operation3)
        
        Logger.info("end")
    }
    
    /// 依赖
    ///
    /// Operation 之间可以添加依赖。
    /// 添加依赖的 Operation 需等待其依赖的 Operation 执行结束后才会开始执行。
    /// 一个 Operation 可以依赖多个 Operation。
    /// 注意：添加依赖时应避免出现循环依赖问题。循环依赖在编译和执行的时候都不会报错，但是会造成相互等待，导致整条依赖链上的任务都不会执行。
    private func dependency() {
        Logger.info("begin")
        
        let operationQueue = OperationQueue()
        
        // Operation1
        let operation1 = BlockOperation {
            Logger.info("Operation1 begin")
            Logger.info("Operation1 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Operation1 end")
        }
        
        // Operation2
        let operation2 = BlockOperation {
            Logger.info("Operation2 begin")
            Logger.info("Operation2 thread: \(Thread.current)")
            sleep(2)
            Logger.info("Operation2 end")
        }
        
        // Operation3
        let operation3 = BlockOperation {
            Logger.info("Operation3 begin")
            Logger.info("Operation3 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Operation3 end")
        }
        
        operation2.addDependency(operation1)
        operation2.addDependency(operation3)
        
        Logger.info("Add Operation1")
        operationQueue.addOperation(operation1)
        
        Logger.info("Add Operation2")
        operationQueue.addOperation(operation2)
        
        Logger.info("Add Operation3")
        operationQueue.addOperation(operation3)
        
        Logger.info("end")
    }
    
    /// 自定义 Operation
    ///
    /// Operation 是一个抽象类，不可直接使用。
    /// 系统提供 NSInvocationOperation（已废弃）和 NSBlockOperation 两个子类。
    /// 也可以自定义一个类继承 Operation 以供使用。
    private func customOperation() {
        Logger.info("begin")
        
        let operationQueue = OperationQueue()
        
        // Operation1
        let operation1 = SimpleOperation()
        
        // Operation2
        let operation2 = SimpleOperation()
        
        // Operation3
        let operation3 = SimpleOperation()
        
        Logger.info("Add Operation1")
        operationQueue.addOperation(operation1)
        
        Logger.info("Add Operation2")
        operationQueue.addOperation(operation2)
        
        Logger.info("Add Operation3")
        operationQueue.addOperation(operation3)
        
        Logger.info("end")
    }
}

// MARK: - 实操
extension OperationViewController {
    /// 下载器
    private func downloader() {
        let viewController = DownloaderViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
