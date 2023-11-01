//
//  GCDViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/7.
//

import UIKit

class GCDViewController: ListViewController {
    
    let viewModel = GCDViewModel()
    
    /// 串行队列
    let serialQueue = DispatchQueue(label: "com.temp.serial.queue")
    
    /// 并行队列
    let concurrentQueue = DispatchQueue(label: "com.temp.concurrent.queue", attributes: .concurrent)
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "初级", rowItems: [
                ListRowItem(title: "同步串行队列", tapAction: { [weak self] in
                    self?.syncSerialQueue()
                }),
                ListRowItem(title: "同步并发队列", tapAction: { [weak self] in
                    self?.syncConcurrentQueue()
                }),
                ListRowItem(title: "异步串行队列", tapAction: { [weak self] in
                    self?.asyncSerialQueue()
                }),
                ListRowItem(title: "异步并发队列", tapAction: { [weak self] in
                    self?.asyncConcurrentQueue()
                })
                
            ]),
            ListSectionItem(title: "进阶", rowItems: [
                ListRowItem(title: "DispatchGroup", tapAction: { [weak self] in
                    self?.dispatchGroup()
                }),
                ListRowItem(title: "DispatchWorkItem.barrier", tapAction: { [weak self] in
                    self?.barrier()
                })
            ])
        ]
    }
    
}

// MARK: - 初级
extension GCDViewController {
    /// 同步串行队列
    ///
    /// 因为是同步执行，当任务被添加到队列中时，任务实质是被放到当前线程中执行，当前线程会被阻塞，只有等待任务完成之后，线程才会被释放，程序继续向下执行。
    /// 这里需要注意，如果当前线程本身在串行队列中执行，并且将任务同步添加到当前程序所处队列中，会照成死锁。
    private func syncSerialQueue() {
        Logger.info("begin")
        
        // Task1
        Logger.info("Add task1")
        serialQueue.sync {
            Logger.info("Task1 begin")
            Logger.info("Task1 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task1 end")
        }
        
        // Task2
        Logger.info("Add task2")
        serialQueue.sync {
            Logger.info("Task2 begin")
            Logger.info("Task2 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task2 end")
        }
        
        // Task3
        Logger.info("Add task3")
        serialQueue.sync {
            Logger.info("Task3 begin")
            Logger.info("Task3 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task3 end")
        }
        
        Logger.info("end")
    }
    
    /// 同步并行队列
    ///
    /// 这里的表现跟`同步串行队列`一致
    /// 可见，同步执行任务，不管是放到串行队列还是并行队列，都不会开辟新的线程，任务会被放到当前线程中执行，当前线程阻塞，等待任务执行完毕才会释放。
    private func syncConcurrentQueue() {
        Logger.info("begin")
        
        // Task1
        Logger.info("Add task1")
        concurrentQueue.sync {
            Logger.info("Task1 begin")
            Logger.info("Task1 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task1 end")
        }
        
        // Task2
        Logger.info("Add task2")
        concurrentQueue.sync {
            Logger.info("Task2 begin")
            Logger.info("Task2 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task2 end")
        }
        
        // Task3
        Logger.info("Add task3")
        concurrentQueue.sync {
            Logger.info("Task3 begin")
            Logger.info("Task3 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task3 end")
        }
        
        Logger.info("end")
    }
    
    /// 异步串行队列
    ///
    /// 因为是异步执行，当任务被添加到队列中时，会开辟新的线程执行任务。任务被丢到同步队列中执行，当前线程不会被阻塞，继续向下执行。
    /// 因为是串行队列，当有多个任务被添加到队列中时，不会开辟多个线程。后进来的任务休眠等待，直到前一个任务执行完毕才会开始执行。
    private func asyncSerialQueue() {
        Logger.info("begin")
        
        // Task1
        Logger.info("Add task1")
        serialQueue.async {
            Logger.info("Task1 begin")
            Logger.info("Task1 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task1 end")
        }
        
        // Task2
        Logger.info("Add task2")
        serialQueue.async {
            Logger.info("Task2 begin")
            Logger.info("Task2 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task2 end")
        }
        
        // Task3
        Logger.info("Add task3")
        serialQueue.async {
            Logger.info("Task3 begin")
            Logger.info("Task3 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task3 end")
        }
        
        Logger.info("end")
    }
    
    /// 异步并行队列
    ///
    /// 异步执行同`异步串行队列`，开辟新的线程执行任务，不会阻塞当前线程。
    /// 因为是并行队列，当有多个任务被添加到队列中时，会开辟多个线程执行任务，多个任务并发执行。
    private func asyncConcurrentQueue() {
        Logger.info("begin")
        
        // Task1
        Logger.info("Add task1")
        concurrentQueue.async {
            Logger.info("Task1 begin")
            Logger.info("Task1 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task1 end")
        }
        
        // Task2
        Logger.info("Add task2")
        concurrentQueue.async {
            Logger.info("Task2 begin")
            Logger.info("Task2 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task2 end")
        }
        
        // Task3
        Logger.info("Add task3")
        concurrentQueue.async {
            Logger.info("Task3 begin")
            Logger.info("Task3 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task3 end")
        }
        
        Logger.info("end")
    }
}

// MARK: - 进阶
extension GCDViewController {
    
    /// Dispatch Group
    ///
    /// 将多个任务打包，进行统一操作。
    /// `notify`方法用于监听所有任务完成的通知，并且可以指定回调函数运行的队列。
    /// `notify`绑定多次，会触发多个回调。
    /// `notify`绑定监听之后，单个任务只会被触发1次。若在触发之后想要继续添加任务到任务组内并监听任务完成回调，则需要再次进行绑定。
    /// `wait`方法会阻塞当前线程，等待所有任务完成后，释放当前线程。
    private func dispatchGroup() {
        let group = DispatchGroup()
        
        Logger.info("begin")
        
        // Task1
        Logger.info("Add task1")
        concurrentQueue.async(group: group) {
            Logger.info("Task1 begin")
            Logger.info("Task1 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task1 end")
        }
        
        // Task2
        Logger.info("Add task2")
        concurrentQueue.async(group: group) {
            Logger.info("Task2 begin")
            Logger.info("Task2 thread: \(Thread.current)")
            sleep(5)
            Logger.info("Task2 end")
        }
        
        // Task3
        Logger.info("Add task3")
        concurrentQueue.async(group: group) {
            Logger.info("Task3 begin")
            Logger.info("Task3 thread: \(Thread.current)")
            sleep(3)
            Logger.info("Task3 end")
        }
        
        group.notify(queue: serialQueue) {
            Logger.info("Task group notify. thread: \(Thread.current)")
        }
        
        group.notify(queue: serialQueue) {
            Logger.info("Task group notify 111. thread: \(Thread.current)")
        }
        
//        group.wait()
        
        Logger.info("end")
    }
    
    /// DispatchWorkItem barrier
    ///
    /// DispatchWorkItem 对任务进行封装，可以自定义任务的优先级和类型。
    /// barrier 是 DispatchWorkItem 中的一种类型，用于对多任务并发顺序进行控制。
    /// barrier 用于分隔 barrier 前后的任务。barrier 中的任务要等待 barrier 之前的所有任务完成之后才会开始执行；barrier 之后的任务需等待 barrier 绑定的任务完成之后才能开始执行。
    /// `wait` 函数会阻塞当前线程，等待barrier中的任务执行完毕才会继续向下执行。
    private func barrier() {
        Logger.info("begin")
        
        // Task1
        Logger.info("Add task1")
        concurrentQueue.async {
            Logger.info("Task1 begin")
            Logger.info("Task1 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task1 end")
        }
        
        // Task2
        Logger.info("Add task2")
        concurrentQueue.async {
            Logger.info("Task2 begin")
            Logger.info("Task2 thread: \(Thread.current)")
            sleep(5)
            Logger.info("Task2 end")
        }
        
        // Task3
        Logger.info("Add task3")
        concurrentQueue.async {
            Logger.info("Task3 begin")
            Logger.info("Task3 thread: \(Thread.current)")
            sleep(3)
            Logger.info("Task3 end")
        }
        
        // Barrier
        Logger.info("Add barrier")
        let workItem = DispatchWorkItem(flags: .barrier) {
            Logger.info("barrier begin")
            Logger.info("barrier thread: \(Thread.current)")
            sleep(3)
            Logger.info("barrier end")
        }
        concurrentQueue.async(execute: workItem)
        
//        workItem.wait()
        
        // Task4
        Logger.info("Add task4")
        concurrentQueue.async {
            Logger.info("Task4 begin")
            Logger.info("Task4 thread: \(Thread.current)")
            sleep(1)
            Logger.info("Task4 end")
        }
        
        // Task5
        Logger.info("Add task5")
        concurrentQueue.async {
            Logger.info("Task5 begin")
            Logger.info("Task5 thread: \(Thread.current)")
            sleep(5)
            Logger.info("Task5 end")
        }
        
        // Task6
        Logger.info("Add task6")
        concurrentQueue.async {
            Logger.info("Task6 begin")
            Logger.info("Task6 thread: \(Thread.current)")
            sleep(3)
            Logger.info("Task6 end")
        }
        
        Logger.info("end")
    }
}
