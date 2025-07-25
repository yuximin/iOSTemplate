//
//  SlotsNumberView.swift
//  OhlaKit
//
//  Created by apple on 2025/7/23.
//

import UIKit
import pop

public class SlotsNumberView: UIView {
    
    private var number: Int = 0
    
    private var numberItemViews: [SlotsNumberItemView] = []
    
    private let count: Int
    private let itemSize: CGSize
    private let itemSpacing: CGFloat
    private let numberSize: CGSize
    private let imageResource: SlotsNumberImageResource
    
    private let maxNumber: Int
    
    // MARK: - Lifecycle
    
    public init(count: Int, itemSize: CGSize, numberSize: CGSize, itemSpacing: CGFloat, imageResource: SlotsNumberImageResource) {
        self.count = count
        self.itemSize = itemSize
        self.numberSize = numberSize
        self.itemSpacing = itemSpacing
        self.imageResource = imageResource
        self.maxNumber = Int(pow(10, Double(count))) - 1
        super.init(frame: .zero)
        
        setupUI()
        setupNumberItemViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        addSubview(numberStackView)
        numberStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupNumberItemViews() {
        self.numberStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        self.numberItemViews.removeAll()
        
        for index in 0..<self.count {
            let numberItemView = SlotsNumberItemView(index: index, numberSize: self.numberSize, imageResource: self.imageResource)
            self.numberItemViews.append(numberItemView)
            self.numberStackView.addArrangedSubview(numberItemView)
            numberItemView.snp.makeConstraints { make in
                make.size.equalTo(self.itemSize)
            }
        }
    }
    
    // MARK: - View
    
    private lazy var numberStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = self.itemSpacing
        stackView.semanticContentAttribute = .forceLeftToRight
        return stackView
    }()
}

// MARK: - Interface
extension SlotsNumberView {
    
    public func setNumber(_ number: Int) {
        let displayNumber = min(number, self.maxNumber)
        
        guard displayNumber != self.number else { return }
        
        self.number = displayNumber
        
        let numberString = String(format: "%0\(self.count)d", displayNumber)
        var itemNumbers = numberString.compactMap { $0.wholeNumberValue }
        
        for (index, numberItemView) in self.numberItemViews.enumerated() {
            let itemNumber: Int
            if index < itemNumbers.count {
                itemNumber = itemNumbers[index]
            } else {
                itemNumber = 0
            }
            
            numberItemView.scrollToNumber(itemNumber)
        }
    }
}

private class SlotsNumberItemView: UIView, UITableViewDataSource, UITableViewDelegate  {
    
    private let index: Int
    private let numberSize: CGSize
    private let imageResource: SlotsNumberImageResource
    
    // MARK: - Lifecycle
    
    init(index: Int, numberSize: CGSize, imageResource: SlotsNumberImageResource) {
        self.index = index
        self.numberSize = numberSize
        self.imageResource = imageResource
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        self.isUserInteractionEnabled = false
        
        addSubview(backgroundView)
        addSubview(tableView)
        
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(self.numberSize)
        }
    }
    
    // MARK: - Interface
    
    func scrollToNumber(_ number: Int) {
        guard let animation = POPBasicAnimation(propertyNamed: kPOPTableViewContentOffset) else { return }
        
        animation.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: tableView.contentOffset.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: 0, y: numberSize.height * 10 + numberSize.height * CGFloat(number)))
        animation.beginTime = CACurrentMediaTime()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.duration = 1.5 + CGFloat(self.index) * 0.3
        self.tableView.pop_add(animation, forKey: "SlotsNumberItemScrollAnimation")
    }
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: SlotsNumberItemCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setNumber(indexPath.row % 10, imageResource: self.imageResource)
        return cell
    }
    
    // MARK: - View
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = self.imageResource.iconBackground
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.rowHeight = self.numberSize.height
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(reusableCell: SlotsNumberItemCell.self)
        return tableView
    }()
}

private class SlotsNumberItemCell: UITableViewCell, Reusable {
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        self.contentView.addSubview(numberImageView)
        numberImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Interface
    
    func setNumber(_ number: Int, imageResource: SlotsNumberImageResource) {
        let image: UIImage
        switch number {
        case 1:
            image = imageResource.n1
        case 2:
            image = imageResource.n2
        case 3:
            image = imageResource.n3
        case 4:
            image = imageResource.n4
        case 5:
            image = imageResource.n5
        case 6:
            image = imageResource.n6
        case 7:
            image = imageResource.n7
        case 8:
            image = imageResource.n8
        case 9:
            image = imageResource.n9
        default:
            image = imageResource.n0
        }
        self.numberImageView.image = image
    }
    
    // MARK: - View
    
    private lazy var numberImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
}

public struct SlotsNumberImageResource {
    
    public let n0: UIImage
    public let n1: UIImage
    public let n2: UIImage
    public let n3: UIImage
    public let n4: UIImage
    public let n5: UIImage
    public let n6: UIImage
    public let n7: UIImage
    public let n8: UIImage
    public let n9: UIImage
    public let iconBackground: UIImage?
    
    public init(n0: UIImage, n1: UIImage, n2: UIImage, n3: UIImage, n4: UIImage, n5: UIImage, n6: UIImage, n7: UIImage, n8: UIImage, n9: UIImage, iconBackground: UIImage?) {
        self.n0 = n0
        self.n1 = n1
        self.n2 = n2
        self.n3 = n3
        self.n4 = n4
        self.n5 = n5
        self.n6 = n6
        self.n7 = n7
        self.n8 = n8
        self.n9 = n9
        self.iconBackground = iconBackground
    }
}
