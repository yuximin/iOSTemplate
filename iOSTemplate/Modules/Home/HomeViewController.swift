//
//  HomeViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/7/6.
//

import UIKit
import SnapKit

class HomeViewController: ListViewController, YNavigationBarStyleProtocol {
    
    var isNavigationBarHidden: Bool {
        true
    }

    // MARK: - life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [
            ListSection(title: "UIKit", rows: [
                ListRow(title: "UIImage"),
                ListRow(title: "UILabel"),
                ListRow(title: "UICollectionView"),
                ListRow(title: "UIStackView"),
                ListRow(title: "LayoutSubviews"),
                ListRow(title: "PresentAndPush"),
                ListRow(title: "Animation"),
                ListRow(title: "WKWebView"),
                ListRow(title: "GradientView"),
                ListRow(title: "UITabBarController")
            ]),
            ListSection(title: "Foundation", rows: [
                ListRow(title: "DateFormatter")
            ]),
            ListSection(title: "组件", rows: [
                ListRow(title: "PK进度条")
            ]),
            ListSection(title: "多线程", rows: [
                ListRow(title: "GCD"),
                ListRow(title: "Operation")
            ]),
            ListSection(title: "网络编程", rows: [
                ListRow(title: "URL"),
                ListRow(title: "UISession"),
                ListRow(title: "Moya")
            ]),
            ListSection(title: "三方库", rows: [
                ListRow(title: "Tiercel - swift下载器"),
                ListRow(title: "Pag - 动效播放"),
                ListRow(title: "融云"),
                ListRow(title: "RxSwift"),
                ListRow(title: "AFNetworking")
            ]),
            ListSection(title: "Codable", rows: [
                ListRow(title: "Demo")
            ]),
            ListSection(title: "示例项目", rows: [
                ListRow(title: "下载器")
            ])
        ]
    }

}

// MARK: - UITableViewDelegate
extension HomeViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController: UIViewController?
        
        let sectionItem = sections[indexPath.section]
        let rowItem = sectionItem.rows[indexPath.row]
        switch (sectionItem.title, rowItem.title) {
        case ("UIKit", "UIImage"):
            viewController = UIImageDemoViewController()
        case ("UIKit", "UILabel"):
            viewController = UILabelDemoViewController()
        case ("UIKit", "UICollectionView"):
            viewController = CollectionViewDemoController()
        case ("UIKit", "UIStackView"):
            viewController = UIStackViewDemoViewController()
        case ("UIKit", "LayoutSubviews"):
            viewController = LayoutSubviewsDemoViewController()
        case ("UIKit", "PresentAndPush"):
            viewController = PresentAndPushViewController()
        case ("UIKit", "Animation"):
            viewController = AnimationDemoViewController()
        case ("UIKit", "WKWebView"):
            viewController = WKWebViewDemoViewController()
        case ("UIKit", "GradientView"):
            viewController = GradientViewController()
        case ("UIKit", "UITabBarController"):
            viewController = TabBarDemoViewController()
        case ("Foundation", "DateFormatter"):
            viewController = DateFormatterDemoViewController()
        case ("组件", "PK进度条"):
            viewController = PKProgressViewController()
        case ("多线程", "GCD"):
            viewController = GCDViewController()
        case ("多线程", "Operation"):
            viewController = OperationViewController()
        case ("网络编程", "URL"):
            viewController = URLDemoViewController()
        case ("网络编程", "UISession"):
            viewController = SessionViewController()
        case ("网络编程", "Moya"):
            viewController = MoyaDemoViewController()
        case ("三方库", "Tiercel - swift下载器"):
            viewController = TiercelDemoViewController()
        case ("三方库", "Pag - 动效播放"):
            viewController = PagDemoViewController()
        case ("三方库", "融云"):
            viewController = RongCloudViewController()
        case ("三方库", "RxSwift"):
            viewController = RxSwiftDemoViewController()
        case ("三方库", "AFNetworking"):
            viewController = AFNetworkingViewController()
        case ("Codable", "Demo"):
            viewController = CodableDemoViewController()
        case ("示例项目", "下载器"):
            viewController = JDownloaderViewController()
        default:
            viewController = nil
        }
        
        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
