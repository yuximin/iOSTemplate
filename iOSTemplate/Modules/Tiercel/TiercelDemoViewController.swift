//
//  TiercelDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/8/30.
//

import UIKit
import Tiercel

class TiercelDemoViewController: ListViewController {
    
    var downloader: TiercelDownloader = {
        let downloader = TiercelDownloader(identifier: "com.download.pag", cacheDirectory: "com.cache.pag")
        return downloader
    }()
    
//    var downloader1: TiercelDownloader = {
//        let downloader = TiercelDownloader(identifier: "com.download.pag", cacheDirectory: "com.cache.pag")
//        return downloader
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloader.cache.clearDiskCache { cache in
//            cache.retrieveAllTasks()
        }
        
    }
    
    override func updateSectionItems() {
        self.sectionItems = [
            ListSectionItem(title: "Base", rowItems: [
                ListRowItem(title: "Test", tapAction: { [weak self] in
                    self?.baseTestDownlader()
                })
            ])
        ]
    }

}

// MARK: - method
extension TiercelDemoViewController {
    
    func baseTestDownlader() {
        let urlString = "https://github.com/yuximin/StaticResources/blame/master/Test/test.zip?raw=true"
        downloader.downloadFileWithURLString(urlString) { progress in
            print("download progress 11 - \(progress.completedUnitCount) \(progress.totalUnitCount)")
        } completion: { result in
            switch result {
            case .success(let path):
                print("download success 11: \(path)")
            case .failure(let error):
                print("download failure 11: \(error.localizedDescription)")
            }
        }
        
//        downloader.downloadFileWithURLString(urlString) { progress in
//            print("download progress 22 - \(progress.completedUnitCount) \(progress.totalUnitCount)")
//        } completion: { result in
//            switch result {
//            case .success(let path):
//                print("download success 22: \(path)")
//            case .failure(let error):
//                print("download failure 22: \(error.localizedDescription)")
//            }
//        }
//
//        downloader.downloadFileWithURLString(urlString) { progress in
//            print("download progress 33 - \(progress.completedUnitCount) \(progress.totalUnitCount)")
//        } completion: { result in
//            switch result {
//            case .success(let path):
//                print("download success 33: \(path)")
//            case .failure(let error):
//                print("download failure 33: \(error.localizedDescription)")
//            }
//        }
//
//        downloader.downloadFileWithURLString(urlString) { progress in
//            print("download progress 44 - \(progress.completedUnitCount) \(progress.totalUnitCount)")
//        } completion: { result in
//            switch result {
//            case .success(let path):
//                print("download success 44: \(path)")
//            case .failure(let error):
//                print("download failure 44: \(error.localizedDescription)")
//            }
//        }
    }
}
