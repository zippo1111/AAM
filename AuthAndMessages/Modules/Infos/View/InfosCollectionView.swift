//
//  InfosCollectionView.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import SnapKit
import UIKit

final class InfosCollectionView: UICollectionView {
    var cellReloadCallback: ((_ url: String?, _ row: Int) -> ())?
    private var viewModelData: [InfoViewModel]?

    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewLayout())

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModelData: [InfoViewModel]?) {
        self.viewModelData = viewModelData
    }

    private func setupView() {
        backgroundColor = UIColor(named: "BGColor")
        showsHorizontalScrollIndicator = false
        scrollsToTop = true

        collectionViewLayout = CustomLayout(
            interItemSpacing: Constants.offsetOuter,
            scrollDirection: .vertical,
            itemHeight: Constants.defaultItemHeight,
            groupInsets: NSDirectionalEdgeInsets(
                top: .leastNormalMagnitude,
                leading: Constants.offsetOuter,
                bottom: .leastNormalMagnitude,
                trailing: Constants.offsetOuter
            )
        )

        register(
            InfoCell.self,
            forCellWithReuseIdentifier: String(describing: InfoCell.self)
        )
    }
}

fileprivate extension InfosCollectionView {
    enum Constants {
        static let defaultItemHeight: CGFloat = 100
        static let offsetInner: CGFloat = 14
        static let offsetOuter: CGFloat = 20
    }
}
