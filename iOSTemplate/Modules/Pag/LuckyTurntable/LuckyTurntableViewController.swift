//
//  LuckyTurntableViewController.swift
//  iOSTemplate
//
//  Created by apple on 2022/9/2.
//

import UIKit
import libpag

class LuckyTurntableViewController: UIViewController {
    
    enum OperationType {
        case join
        case go
        
        var title: String {
            switch self {
            case .join:
                return "Join"
            case .go:
                return "Go"
            }
        }
    }
    
    struct UserInfo: Equatable {
        let name: String
        var avatar: UIImage?
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.name == rhs.name
        }
    }
    
    let operations: [OperationType] = [.join, .go]
    
    let players: [UserInfo] = [
        UserInfo(name: "珍珠奶茶", avatar: UIImage(named: "lucky_turntable_player_0")),
        UserInfo(name: "棒棒糖", avatar: UIImage(named: "lucky_turntable_player_1")),
        UserInfo(name: "汉堡", avatar: UIImage(named: "lucky_turntable_player_2")),
        UserInfo(name: "泡面", avatar: UIImage(named: "lucky_turntable_player_3")),
        UserInfo(name: "披萨", avatar: UIImage(named: "lucky_turntable_player_4")),
        UserInfo(name: "肉夹馍", avatar: UIImage(named: "lucky_turntable_player_5")),
        UserInfo(name: "薯条", avatar: UIImage(named: "lucky_turntable_player_6")),
        UserInfo(name: "冰淇淋", avatar: UIImage(named: "lucky_turntable_player_7")),
        UserInfo(name: "雪糕", avatar: UIImage(named: "lucky_turntable_player_8")),
        UserInfo(name: "章鱼小丸子", avatar: UIImage(named: "lucky_turntable_player_9"))
    ]
    
    var joinPlayers: [UserInfo] = [] // 玩家加入顺序列表
    var playersSort: [UserInfo] = [] // 玩家淘汰顺序列表
    
    private var pagFile: PAGFile?
    private var lastFrame: Int = 0
    
    // MARK: - view
    
    private lazy var pagView: PAGView = {
        let view = PAGView()
        view.setRepeatCount(1)
        view.add(self)
        return view
    }()
    
    private lazy var operationView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5.0
        return stackView
    }()
    
    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPagFile()
        doReset()
    }
    
    // MARK: - ui
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(pagView)
        pagView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(operationView)
        operationView.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualToSuperview()
            make.trailing.lessThanOrEqualToSuperview()
            make.bottom.equalToSuperview().inset(50.0)
            make.centerX.equalToSuperview()
        }
        
        for (idx, item) in operations.enumerated() {
            let button = createButton(tag: idx, title: item.title)
            operationView.addArrangedSubview(button)
        }
    }
    
    // MARK: - helper
    
    private func createButton(tag: Int, title: String) -> UIButton {
        let button = UIButton()
        button.tag = tag
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(didTapOperationButton(_:)), for: .touchUpInside)
        return button
    }
    
    // MARK: - action
    
    @objc private func didTapOperationButton(_ sender: UIButton) {
        let tag = sender.tag
        if tag < 0 || tag > operations.count {
            return
        }
        
        let operation = operations[tag]
        switch operation {
        case .join:
            doJoin()
        case .go:
            doGo()
        }
    }
    
    // MARK: - operation
    
    private func doJoin() {
        playerJoin()
        pagJoin()
    }
    
    private func doGo() {
        if joinPlayers.count <= 1 {
            print("[幸运转盘] 玩家人数不足，无法开始")
            return
        }
        
        print("[幸运转盘] 开启转盘 [\(joinPlayers.map({ $0.name }).joined(separator: ","))]")
        sorePlayersWeedOut()
        pagGo()
    }
    
    private func doReset() {
        playerReset()
        pagReset()
    }

}

// MARK: - Player
extension LuckyTurntableViewController {
    
    private func playerReset() {
        let idx = Int(arc4random()) % players.count
        let player = players[idx]
        joinPlayers = [player]
        print("[幸运转盘] 创建游戏，玩家\"\(player.name)\"加入\(joinPlayers.count)号位")
    }
    
    private func playerJoin() {
        var players = self.players
        players.removeAll { self.joinPlayers.contains($0) }
        
        if players.isEmpty {
            return
        }
        
        let idx = Int(arc4random()) % players.count
        let player = players[idx]
        joinPlayers.append(player)
        print("[幸运转盘] 玩家\"\(player.name)\"加入\(joinPlayers.count)号位")
    }
    
    /// 确定玩家淘汰顺序
    private func sorePlayersWeedOut() {
        var players = joinPlayers
        var playersSort: [UserInfo] = []
        while !players.isEmpty {
            let idx = Int(arc4random()) % players.count
            let player = players.remove(at: idx)
            playersSort.append(player)
        }
        self.playersSort = playersSort
        print("[幸运转盘] 玩家淘汰顺序 [\(playersSort.map({ $0.name}).joined(separator: ","))]")
    }
}

// MARK: - PAGView
extension LuckyTurntableViewController {
    
    /// 加载转盘资源
    ///
    /// 转盘资源总时长 52.0s
    ///
    /// 初始时刻为单人状态，后续每个玩家加入动画时长为0.5秒，人数最多为10。
    /// 玩家加入后，直接设置到对应人数加入完成后的进度即可。即第2个人加入时对应0.5s,第3个人加入时对应1.0s,...第10个人加入时对应4.5s.
    ///
    /// 5.0s时刻开始转盘转动，5.0s对应10人开始转动，后续每淘汰1名玩家动画时长为5s。
    /// 开始转动前，需要判断当前人数，切换到对应进度，然后开始播放动画，依次淘汰玩家
    private func loadPagFile() {
        guard let path = Bundle.main.path(forResource: "luckyTurntable", ofType: "pag") else {
            return
        }
        
        guard let pagFile = PAGFile.load(path) else {
            return
        }
        
        pagView.snp.remakeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(pagView.snp.width).multipliedBy(CGFloat(pagFile.height()) / CGFloat(pagFile.width()))
        }
        
        self.pagFile = pagFile
        pagView.setComposition(pagFile)
        pagView.flush()
        
        // 历史记录
        let ratio = UIScreen.main.bounds.width / 750.0
        let rect = pagView.convert(CGRect(x: 37.0 * ratio, y: 239.0 * ratio, width: 66.0 * ratio, height: 66.0 * ratio), to: view)
        let recordButton = UIButton()
        recordButton.frame = rect
        recordButton.backgroundColor = .blue.withAlphaComponent(0.3)
//        recordButton.addTarget(self, action: #selector(didTapRecord(_:)), for: .touchUpInside)
        view.addSubview(recordButton)
        print(CGRect(x: 37.0 * ratio, y: 239.0 * ratio, width: 66.0 * ratio, height: 66.0 * ratio))
        print(rect)
        
        print(pagView.frame)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            print(self.pagView.frame)
            recordButton.frame = self.pagView.convert(CGRect(x: 37.0 * ratio, y: 239.0 * ratio, width: 66.0 * ratio, height: 66.0 * ratio), to: self.view)
        }
        
        let maxDuration = Double(pagFile.duration()) / 1000000.0
        let maxFrame = Int(maxDuration * 30)
        print("[幸运转盘] 总时长: \(maxDuration), 总帧数: \(maxFrame)")
    }
    
    /// 加入转盘
    private func pagJoin() {
        if joinPlayers.count > 10 {
            return
        }
        pagJoinReplaceImage(number: joinPlayers.count)
        
        let progress = Double(joinPlayers.count - 1) * 0.5 / 52.0
        pagView.setProgress(progress)
        pagView.flush()
    }
    
    /// 玩家加入时，替换座位头像
    ///
    /// @param number 座位编号
    private func pagJoinReplaceImage(number: Int) {
        if let pagFile = pagFile,
           let imageLayer = pagFile.getLayersByName("\(number)").first as? PAGImageLayer,
           number <= joinPlayers.count,
           let image = joinPlayers[number - 1].avatar,
           let cgImage = image.cgImage {
            imageLayer.setImage(PAGImage.fromCGImage(cgImage))
        }
    }
    
    private func refreshJoinImage() {
        guard let pagFile = pagFile else {
            return
        }
        
        for i in 0..<joinPlayers.count {
            if let imageLayer = pagFile.getLayersByName("\(i + 1)").first as? PAGImageLayer,
               let image = joinPlayers[i].avatar,
               let cgImage = image.cgImage {
                imageLayer.setImage(PAGImage.fromCGImage(cgImage))
            }
        }
    }
    
    /// 转盘转动
    private func pagGo() {
        let progress =  (5.0 + Double(10 - joinPlayers.count) * 5.0) / 52.0
        pagView.setProgress(progress)
        pagView.play()
    }
    
    /// 重置转盘
    private func pagReset() {
        pagJoinReplaceImage(number: joinPlayers.count)
        pagView.setProgress(0)
        pagView.flush()
    }
}

// MARK: - PAGViewListener
extension LuckyTurntableViewController: PAGViewListener {
    func onAnimationStart(_ pagView: PAGView!) {}
    
    func onAnimationEnd(_ pagView: PAGView!) {
        doReset()
    }
    
    func onAnimationCancel(_ pagView: PAGView!) {}
    
    func onAnimationRepeat(_ pagView: PAGView!) {}
    
    func onAnimationUpdate(_ pagView: PAGView!) {
        let frame = Int(pagView.getProgress() * 52.0 * 30.0)
//        print("onAnimationUpdate, \(frame)帧")
        if playersSort.count > 1 {
            let exchangeFrame = 180 + (10 - playersSort.count) * 150 // 头像交换帧数
            if frame == exchangeFrame {
                let userInfo = playersSort.removeFirst()
                if let index = joinPlayers.firstIndex(of: userInfo), joinPlayers.last != userInfo {
                    let count = joinPlayers.count
                    let lastJoinUserInfo = joinPlayers[count - 1]
                    joinPlayers[index] = lastJoinUserInfo
                    joinPlayers[count - 1] = userInfo
                    print("[幸运转盘] 玩家头像交换 [\(userInfo.name), \(lastJoinUserInfo.name)]")
                    refreshJoinImage()
                }
                print("[幸运转盘] 玩家淘汰 [\(userInfo.name)]")
                joinPlayers.removeLast()
            }
        }
    }
}
