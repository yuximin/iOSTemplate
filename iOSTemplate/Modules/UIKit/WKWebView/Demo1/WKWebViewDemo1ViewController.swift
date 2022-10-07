//
//  WKWebViewDemo1ViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/28.
//

import UIKit
import WebKit

class WKWebViewDemo1ViewController: UIViewController {
    
    // MARK: - view
    
//    private lazy var webView: WKWebView = {
//        let userContentController = WKUserContentController()
//        userContentController.add(self, name: "closeGame")
//        userContentController.add(self, name: "pay")
//
////        let preferences = WKPreferences()
////        preferences.javaScriptCanOpenWindowsAutomatically = true
////        preferences.javaScriptEnabled = true
//
//        let js = "window.webkit.messageHandlers.closeGame.postMessage(\"aaa\");"
//        let script = WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
//
//        let webConfiguration = WKWebViewConfiguration()
//        webConfiguration.userContentController.addUserScript(script)
//        webConfiguration.userContentController = userContentController
////        webConfiguration.preferences = preferences
//
//        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
////        webView.isOpaque = false
////        webView.uiDelegate = self
//        return webView
//    }()
    
    var webView: WKWebView?

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        load()
    }

    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "pay")
        userContentController.add(self, name: "closeGame")
        
        let config = WKWebViewConfiguration()
        config.userContentController = userContentController
        
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = self
        self.webView = webView
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let button = UIButton()
        button.setTitle("点击", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 120.0, height: 30.0))
        }
    }
    
    private func load() {
//        guard let url = URL(string: "https://test-m.ohlaapp.cn/FAQ.html") else {
//            return
//        }
//
//        let request = URLRequest(url: url)
//        webView?.load(request)
        
        guard let path = Bundle.main.path(forResource: "test", ofType: "html") else {
            return
        }

        guard let htmlString = try? String(contentsOfFile: path, encoding: .utf8) else {
            return
        }

        webView?.loadHTMLString(htmlString, baseURL: nil)
    }
    
    // MARK: - action
    
    @objc func didTapButton() {
        webView?.evaluateJavaScript("postPay()") { obj, error in
            print("")
        }
    }
    
    @objc func closeGame(args: [String: Any]?) {
        print("关闭游戏")
    }
    
    @objc func pay(args: [String: Any]?) {
        print("支付")
    }
}

// MARK: - WKScriptMessageHandler
extension WKWebViewDemo1ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let selector = NSSelectorFromString(message.name)
        if responds(to: selector) {
            perform(selector, with: message.body)
        } else {
            print("未实现方法: \(message.name) -> \(message.body)")
        }
    }
}

// MARK: - WKUIDelegate
extension WKWebViewDemo1ViewController: WKUIDelegate {
    
}
