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
    
    override func updateSectionItems() {
        sectionItems = [
            ListSectionItem(title: "UIKit", rowItems: [
                ListRowItem(title: "UIImage", tapAction: { [weak self] in
                    let viewController = UIImageDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "UILabel", tapAction: { [weak self] in
                    let viewController = UILabelDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "UICollectionView", tapAction: { [weak self] in
                    let viewController = CollectionViewDemoController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "UIStackView", tapAction: { [weak self] in
                    let viewController = UIStackViewDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "LayoutSubviews", tapAction: { [weak self] in
                    let viewController = LayoutSubviewsDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "PresentAndPush", tapAction: { [weak self] in
                    let viewController = PresentAndPushViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "Animation", tapAction: { [weak self] in
                    let viewController = AnimationDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "WKWebView", tapAction: { [weak self] in
                    let viewController = WKWebViewDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "GradientView", tapAction: { [weak self] in
                    let viewController = GradientViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "UITabBarController", tapAction: { [weak self] in
                    let viewController = TabBarDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "DemoUIViewController", tapAction: { [weak self] in
                    let viewController = DemoUIViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ]),
            ListSectionItem(title: "Foundation", rowItems: [
                ListRowItem(title: "DateFormatter", tapAction: { [weak self] in
                    let viewController = DateFormatterDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ]),
            ListSectionItem(title: "组件", rowItems: [
                ListRowItem(title: "PK进度条", tapAction: { [weak self] in
                    let viewController = PKProgressViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ]),
            ListSectionItem(title: "多线程", rowItems: [
                ListRowItem(title: "GCD", tapAction: { [weak self] in
                    let viewController = GCDViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "Operation", tapAction: { [weak self] in
                    let viewController = OperationViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ]),
            ListSectionItem(title: "网络编程", rowItems: [
                ListRowItem(title: "URL", tapAction: { [weak self] in
                    let viewController = URLDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "UISession", tapAction: { [weak self] in
                    let viewController = SessionViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "Moya", tapAction: { [weak self] in
                    let viewController = MoyaDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ]),
            ListSectionItem(title: "三方库", rowItems: [
                ListRowItem(title: "Tiercel - swift下载器", tapAction: { [weak self] in
                    let viewController = TiercelDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "Pag - 动效播放", tapAction: { [weak self] in
                    let viewController = PagDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "融云", tapAction: { [weak self] in
                    let viewController = RongCloudViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "RxSwift", tapAction: { [weak self] in
                    let viewController = RxSwiftDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "AFNetworking", tapAction: { [weak self] in
                    let viewController = AFNetworkingViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ]),
            ListSectionItem(title: "Codable", rowItems: [
                ListRowItem(title: "Demo", tapAction: { [weak self] in
                    let viewController = CodableDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ]),
            ListSectionItem(title: "示例项目", rowItems: [
                ListRowItem(title: "下载器", tapAction: { [weak self] in
                    let viewController = JDownloaderViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }),
                ListRowItem(title: "二维码扫描", tapAction: { [weak self] in
                    let viewController = QRCodeScanDemoViewController()
                    self?.navigationController?.pushViewController(viewController, animated: true)
                })
            ])
        ]
    }
}
