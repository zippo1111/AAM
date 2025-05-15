//
//  CustomLayout.swift
//  ImageTappable
//
//  Created by Mangust on 03.05.2025.
//

import UIKit

final class CustomLayout: UICollectionViewCompositionalLayout {
    init(
        interItemSpacing: CGFloat = Constants.defaultInterItemSpacing,
        scrollDirection: UICollectionView.ScrollDirection = .vertical,
        itemHeight: CGFloat = Constants.defaultItemHeight +  Constants.estimatedItemHeightOffset,
        groupInsets: NSDirectionalEdgeInsets = .zero
    ) {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = scrollDirection

        super.init(sectionProvider: { sectionIndex, env in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(Constants.defaultItemHeight + Constants.estimatedItemHeightOffset)
                )
            )
            item.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(0), top: .fixed(interItemSpacing), trailing: .fixed(0), bottom: .fixed(interItemSpacing))

            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(itemHeight)
                ),
                subitem: item,
                count: 1
            )
            group.interItemSpacing = .fixed(interItemSpacing)
            group.contentInsets = groupInsets

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = .zero

            return section
        }, configuration: config
        )
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension CustomLayout {
    enum Constants {
        static let sizeWidthDimension: NSCollectionLayoutDimension = .fractionalWidth(1)
        static let sizeHeightDimension: NSCollectionLayoutDimension = .fractionalHeight(1)
        static let defaultItemHeight: CGFloat = 100
        static let estimatedItemHeightOffset: CGFloat = 20
        static let defaultInterItemSpacing: CGFloat = 0
    }
}
