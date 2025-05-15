//
//  InfoCell.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import SnapKit
import UIKit

final class InfoCell: UICollectionViewCell {
    var id: Int?

    private var viewModel: InfoViewModel?
    private var row: Int = 0

    private let imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.cornerRadius
        imageView.clipsToBounds = true

        return imageView
    }()
    private var title: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    private let subtitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    private let datetime: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .fill
        stack.distribution = .fill
        return stack
    }()

    private let spinner = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(viewModel: InfoViewModel?, row: Int) {
        guard let viewModel = viewModel else {
            return
        }

        self.viewModel = viewModel
        self.row = row

        Task {
            await setupData(viewModel)
            configureConstraints()
            

        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
    }

    private func setupView() {
        contentView.addSubview(imageView)
        contentView.addSubview(infoStackView)

        infoStackView.addArrangedSubview(title)
        infoStackView.addArrangedSubview(subtitle)
        infoStackView.addArrangedSubview(datetime)

        imageView.addSubview(spinner)
    }

    private func configureConstraints() {
        imageView.snp.makeConstraints {
            $0.height.width.equalTo(Constants.imageHeight)
            $0.top.left.equalToSuperview()
        }
        infoStackView.snp.makeConstraints {
            $0.left.equalTo(imageView.snp.right).offset(14)
            $0.top.equalToSuperview().offset(4)
            $0.right.bottom.equalToSuperview().inset(4)
        }
        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func setupData(_ viewModelData: InfoViewModel) async {
        viewModel = viewModelData

        imageView.image = UIImage(systemName: "photo.artframe")
        title.text = viewModelData.title
        subtitle.text = viewModelData.text
        datetime.text = viewModelData.date
        guard let imageAddress = viewModelData.image,
              let url = URL(string: imageAddress) else {
            showSpinnerInImage()
            return
        }

        hideSpinnerInImage()

        await imageView.loadImage(from: url)
    }

    private func showSpinnerInImage() {
        spinner.startAnimating()
    }

    private func hideSpinnerInImage() {
        spinner.stopAnimating()
    }
}

fileprivate extension InfoCell {
    enum Constants {
        static let offsetInner: CGFloat = 0
        static let offsetOuter: CGFloat = 0
        static let imageHeight: CGFloat = 100
        static let cornerRadius: CGFloat = 12
    }
}
