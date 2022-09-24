//
//  RongCloudViewModel.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/23.
//

import Foundation
import RongIMKit

class RongCloudViewModel: NSObject {
    
    override init() {
        super.init()
        initSDK()
    }
    
    // MARK: - 初始化SDK
    
    private func initSDK() {
        RCIM.shared().initWithAppKey("kj7swf8okx982")
        RCIM.shared().connectionStatusDelegate = self
        RCIM.shared().receiveMessageDelegate = self
    }
    
    // MARK: - 账号登录
    
    public func connectUser1(dbOpened dbOpenedBlock: ((Int) -> Void)? = nil, completion: ((Result<String?, Error>) -> Void)? = nil) {
        connectServer(withToken: "j64j3Nn9WJrO3DUrs4OMP1cvWnCVuxRFOVOfXa2mtfw=@1qv1.cn.rongnav.com;1qv1.cn.rongcfg.com", dbOpened: dbOpenedBlock, completion: completion)
    }
    
    public func connectUser2(dbOpened dbOpenedBlock: ((Int) -> Void)? = nil, completion: ((Result<String?, Error>) -> Void)? = nil) {
        connectServer(withToken: "j64j3Nn9WJr34zFV5uN9c1cvWnCVuxRFO+TxhUkjA1Q=@1qv1.cn.rongnav.com;1qv1.cn.rongcfg.com", dbOpened: dbOpenedBlock, completion: completion)
    }
    
    private func connectServer(withToken token: String, dbOpened dbOpenedBlock: ((Int) -> Void)? = nil, completion: ((Result<String?, Error>) -> Void)? = nil) {
        RCIM.shared().connect(withToken: token) { errorCode in
            // 消息数据库打开，可以进入主界面
            print("ℹ️ 消息数据库打开，可以进入主界面 \(errorCode)")
            dbOpenedBlock?(errorCode.rawValue)
        } success: { userId in
            // 连接成功，可以跳转至会话列表页
            Logger.info("连接服务器成功")
            completion?(.success(userId))
        } error: { errorCode in
            if errorCode == RCConnectErrorCode.RC_CONN_TOKEN_INCORRECT {
                // 从 APP 服务获取新 token，并重连
                Logger.error("从APP服务获取新token，并重连")
            } else {
                // 无法连接到IM服务器
                Logger.error("无法连接到IM服务器（\(errorCode)）")
            }
            completion?(.failure(NSError(domain: "连接IM服务器失败", code: errorCode.rawValue)))
        }

    }
    
    // MARK: - 发送消息
    
    public func sendMessage(content: String, toUser userId: String) {
        let txtMsg = RCTextMessage(content: content)
        
        RCIM.shared().sendMessage(RCConversationType.ConversationType_PRIVATE,
                                       targetId: userId,
                                       content: txtMsg,
                                       pushContent: nil,
                                       pushData: nil) { messageId in
            Logger.info("消息发送成功, messageId: \(messageId)")
        } error: { errCode, messageId in
            Logger.error("消息发送失败, errorCode: \(errCode.rawValue), messageId: \(messageId)")
        }

    }
}

// MARK: - RCIMConnectionStatusDelegate
extension RongCloudViewModel: RCIMConnectionStatusDelegate {
    func onRCIMConnectionStatusChanged(_ status: RCConnectionStatus) {
        Logger.info("onRCIMConnectionStatusChanged \(status)")
    }
}

// MARK: - RCIMReceiveMessageDelegate
extension RongCloudViewModel: RCIMReceiveMessageDelegate {
    func onRCIMReceive(_ message: RCMessage!, left: Int32) {
        let content = message.content?.rawJSONData?.base64EncodedString() ?? "nil"
        Logger.info("接收IM消息: \(content)")
    }
}
