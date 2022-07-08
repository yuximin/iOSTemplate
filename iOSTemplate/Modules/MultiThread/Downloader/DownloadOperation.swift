//
//  DownloadOperation.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/8.
//

import UIKit

class DownloadOperation: Operation {

    override func main() {
        Logger.info("download begin: \(name ?? "unknown")")
        DispatchQueue.global().asyncAfter(deadline: .now() + 5) {
            Logger.info("download completed: \(self.name ?? "unknown")")
        }
    }
}
