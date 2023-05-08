//
//  MoyaDemoViewController.swift
//  iOSTemplate
//
//  Created by apple on 2023/4/24.
//

import UIKit
import Moya
import RxSwift

class MoyaDemoViewController: UIViewController {
    
//    private let provider = MoyaProvider<MoyaDemoAPI>()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Moya"
        view.backgroundColor = .white
        
        view.addSubview(testButton)
        testButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - view
    
    private lazy var testButton: UIButton = {
        let button = UIButton()
        button.setTitle("网络请求", for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(didTapTest(_:)), for: .touchUpInside)
        return button
    }()
}

// MARK: - action
extension MoyaDemoViewController {
    @objc private func didTapTest(_ sender: UIButton) {
        test()
    }
}

// MARK: - private
extension MoyaDemoViewController {
    private func test() {
        let provider = MoyaProvider<MoyaDemoAPI>()
        provider.rx.request(.userInfo).subscribe { event in
            switch event {
            case .success(let res):
                print("whaley log -- res: \(res.statusCode)")
            case .failure(let error):
                print("whaley log -- error: \(error)")
            }
        }.disposed(by: disposeBag)
//        provider.request(.userInfo) { result in
//            switch result {
//            case .success(let response):
//                print("Moya demo request success: \(response.statusCode)")
//                let data = response.data
//                if let jsonDic = try? JSONSerialization.jsonObject(with: data) {
//                    print("")
//                }
//            case .failure(let error):
//                print("Moya demo request failure: \(error.localizedDescription)")
//            }
//        }
    }
}

enum MoyaDemoAPI {
    case userInfo
}

extension MoyaDemoAPI: TargetType {
    var baseURL: URL {
        URL(string: "https://raw.githubusercontent.com/")!
    }
    
    var path: String {
        switch self {
        case .userInfo:
            return "yuximin/StaticResources/master/Json/userInfo.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userInfo:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .userInfo:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers: [String: String]? {
        return nil
    }
}
