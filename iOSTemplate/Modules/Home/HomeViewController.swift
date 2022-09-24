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
                ListRow(title: "PresentAndPush")
            ]),
            ListSection(title: "多线程", rows: [
                ListRow(title: "GCD"),
                ListRow(title: "Operation")
            ]),
            ListSection(title: "网络编程", rows: [
                ListRow(title: "UISession")
            ]),
            ListSection(title: "三方库", rows: [
                ListRow(title: "Tiercel - swift下载器"),
                ListRow(title: "Pag - 动效播放"),
                ListRow(title: "融云")
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
        case ("多线程", "GCD"):
            viewController = GCDViewController()
        case ("多线程", "Operation"):
            viewController = OperationViewController()
        case ("网络编程", "UISession"):
            viewController = SessionViewController()
        case ("三方库", "Tiercel - swift下载器"):
            viewController = TiercelDemoViewController()
        case ("三方库", "Pag - 动效播放"):
            viewController = PagDemoViewController()
        case ("三方库", "融云"):
            viewController = RongCloudViewController()
        default:
            viewController = nil
        }
        
        if let viewController = viewController {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
