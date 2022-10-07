//
//  CodableDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/10/7.
//

import UIKit

class CodableDemoViewController: UIViewController {
    
    private let jsonString = "{\"room\":[{\"id\":10000355,\"name\":\"86ohla50111Pesta\",\"heat\":3,\"count\":0,\"bulletin\":\"Selamat Datang! Siap untuk berpesta? 🎉\",\"country\":\"ID\"}],\"user\":[{\"id\":10103267,\"nick\":\"11\",\"avatar\":\"https://test-image.ohlaapp.cn/photo/b54f70581ad37fc0c30aff3af170910c_w121_h121.png\",\"followed\":0,\"vip_level\":0},{\"id\":10102762,\"nick\":\"10211111111\",\"avatar\":\"https://test-image.ohlaapp.cn/photo/2022714/99ca946a3d6d425c8551fb7b41cdb995.jpg\",\"followed\":1,\"vip_level\":2}]}"
    
    private var model: CodableModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        demo()
    }
    
    private func demo() {
        decodeDemo()
        encodeDemo()
    }
    
    private func decodeDemo() {
        print("Decode data")
        guard let data = jsonString.data(using: .utf8) else {
            print("Decode data error: data is nil")
            return
        }
        
        do{
            let model = try JSONDecoder().decode(CodableModel.self, from: data)
            self.model = model
            print("Decode data result:", model)
        } catch {
            print("Decode data error: \(error.localizedDescription)")
        }
    }
    
    private func encodeDemo() {
        print("Encode data")
        
        guard let model = model else {
            print("Encode data error: model is nil.")
            return
        }
        
        do{
            let data = try JSONEncoder().encode(model)
            let dic = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.fragmentsAllowed)
            print("Encode data result:", dic)
        } catch {
            print("Encode data error: \(error.localizedDescription)")
        }
    }

}
