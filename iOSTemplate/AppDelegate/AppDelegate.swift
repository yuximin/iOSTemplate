//
//  AppDelegate.swift
//  iOSTemplate
//
//  Created by whaley on 2022/4/8.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var timer: DispatchSourceTimer?
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = YNavigationController(rootViewController: HomeViewController())
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
//        beginBackgroundTask()
//        startTimer()
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
//        endBackgroundTaskIfNeed()
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        print("application handleEventsForBackgroundURLSession")
        completionHandler()
    }
    
    // MARK: - background task
    
    func beginBackgroundTask() {
        print("UIApplication beginBackgroundTask")
        
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask { [weak self] in
            guard let self = self else { return }
            
            print("UIApplication beginBackgroundTask expirationHandler")
            
            self.endBackgroundTaskIfNeed()
        }
    }
    
    func endBackgroundTaskIfNeed() {
        print("UIApplication endBackgroundTask")
        
        guard let backgroundTaskIdentifier = self.backgroundTaskIdentifier else {
            return
        }
        
        UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
        self.backgroundTaskIdentifier = .invalid
    }
    
    // MARK: - timer
    
    func startTimer() {
        if let timer = timer {
            timer.resume()
        }
        
        let timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        timer.schedule(deadline: .now(), repeating: .seconds(1))
        timer.setEventHandler {
            print("UIApplication backgroundTimeRemaining: \(UIApplication.shared.backgroundTimeRemaining)")
        }
        timer.resume()
        self.timer = timer
    }
    
    func cancelTimer() {
        timer?.cancel()
        timer = nil
    }
    
    // MARK: - background download task
    
    private lazy var session: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.background(withIdentifier: "com.iosTemplate.background.download")
        sessionConfiguration.sessionSendsLaunchEvents = true
        sessionConfiguration.isDiscretionary = true
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        return session
    }()
    
    func startBackgroundDownloadTask() {
        guard let url = URL(string: "https://test-static.ohlaapp.cn/d/9e846864e3c43488a90f269adc34082e.pag") else {
            return
        }
        
        
        print("开始下载")
        
        let downloadTask = session.downloadTask(with: url)
        downloadTask.resume()
    }

}

// MARK: - URLSessionTaskDelegate
extension AppDelegate: URLSessionDownloadDelegate {
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        print("urlSessionDidFinishEvents forBackgroundURLSession")
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("urlSession didCompleteWithError")
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("urlSession downloadTask didFinishDownloadingTo \(location.absoluteString)")
        startBackgroundDownloadTask()
    }

    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
//        print("urlSession downloadTask didWriteData: \(bytesWritten), \(totalBytesWritten), \(totalBytesExpectedToWrite)")
    }

    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
//        print("urlSession downloadTask didResumeAtOffset: \(fileOffset), \(expectedTotalBytes)")
    }
}

