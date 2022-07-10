//
//  SessionViewModel.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/9.
//

import Foundation

struct SessionViewModel {
    
    let session = URLSession()
    
    let jsonUrl: String = "https://raw.githubusercontent.com/yuximin/StaticResources/master/Json/userInfo.json"
    
    func requestJson() {
        guard let url = URL(string: jsonUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = (response as? HTTPURLResponse), httpResponse.statusCode == 200 else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let jsonObject = (try JSONSerialization.jsonObject(with: data) as? [String: Any]) {
                    Logger.info("Response data:", jsonObject)
                }
                
                let userInfo = try JSONDecoder().decode(UserInfoModel.self, from: data)
                Logger.info("Decode data succeed:", userInfo)
                
                let tempData = try JSONEncoder().encode(userInfo)
                Logger.info("Encode userInfo succeed:", tempData.count)
                
                let tempUserInfo = try JSONDecoder().decode(UserInfoModel.self, from: tempData)
                Logger.info("ReDecode data succeed:", tempUserInfo)
            } catch {
                Logger.info(error.localizedDescription)
            }
        }
        task.resume()
    }
}
