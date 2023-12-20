//
//  ServiceManager.swift
//  iOSTemplate
//
//  Created by apple on 2023/12/19.
//

import Foundation

class ServiceManager {
    
    static let shared = ServiceManager()
    
    private var moduleConfigureDict: [String: String] = [:]
    
    func registerModuleFromPlistFile(_ fileName: String) {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "plist"),
              let fileData = FileManager.default.contents(atPath: path),
              let plistObject = try? PropertyListSerialization.propertyList(from: fileData, options: [], format: nil),
              let configList = plistObject as? [[String: String]]  else {
            return
        }
        
        for configItem in configList {
            if let protocolName = configItem["ProtocolName"],
               let moduleName = configItem["ModuleName"] {
                self.registerModuleWithProtocolName(protocolName, andModuleName: moduleName)
            }
        }
    }
    
    func registerModuleWithProtocolName(_ protocolName: String, andModuleName moduleName: String) {
        guard self.moduleConfigureDict[protocolName] == nil else {
            print("Register module <\(moduleName)> fail: \(protocolName) already registered.")
            return
        }
        
        guard let moduleClass = NSClassFromString(moduleName) else {
            print("Register module <\(moduleName)> fail: class undefined.")
            return
        }
        
        guard moduleClass is NSObject.Type else {
            print("Register module <\(moduleName)> fail: class not inherited from NSObject.")
            return
        }
        
        self.moduleConfigureDict[protocolName] = moduleName
    }
    
    func createModuleWithProtocol(_ aProtocol: Protocol) -> Any? {
        let protocolName = NSStringFromProtocol(aProtocol)
        return self.createModuleWithProtocolName(protocolName)
    }
    
    func createModuleWithProtocolName(_ protocolName: String) -> Any? {
        guard let moduleName = self.moduleConfigureDict[protocolName] else {
            print("create module <\(protocolName)> fail: unregistered.")
            return nil
        }
        
        guard let moduleClass = NSClassFromString(moduleName) else {
            print("create module <\(protocolName)> fail: <\(moduleName)> class undefined.")
            return nil
        }
        
        guard let moduleNSObjectClass = moduleClass as? NSObject.Type else {
            print("create module <\(protocolName)> fail: <\(moduleName)> class not inherited from NSObject.")
            return nil
        }
        
        return moduleNSObjectClass.init()
    }
}
