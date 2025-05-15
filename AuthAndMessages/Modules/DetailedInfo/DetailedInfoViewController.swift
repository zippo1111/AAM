//
//  DetailedInfoViewController.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import UIKit

final class DetailedInfoViewController: UIViewController {
    private var viewModel: InfoViewModel?
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: nil)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        return imageView
    }()
    private var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()
    private let subtitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        return label
    }()

    init(viewModel: InfoViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        setupNavigation()
        setupViews()
        configureViews()

        Task {
            await updateData()
        }
    }

    private func setupNavigation() {
        navigationItem.title = viewModel?.title
        navigationController?.navigationBar.tintColor = .black
    }

    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitle)
    }

    private func configureViews() {
        imageView.snp.makeConstraints {
            $0.height.width.greaterThanOrEqualTo(80)
            $0.centerX.equalToSuperview()
            $0.top.left.right.equalToSuperview().inset(60)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(14)
            $0.left.right.equalToSuperview().inset(16)
            $0.height.greaterThanOrEqualTo(1)
        }
        subtitle.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.left.right.equalTo(titleLabel)
            $0.height.greaterThanOrEqualTo(1)
            $0.bottom.equalToSuperview().inset(14)
        }
    }

    private func updateData() async {
        guard let viewModel = viewModel else {
            return
        }

        if let address = viewModel.image,
           let url = URL(string: address) {
           await imageView.loadImage(from: url)
        }

        titleLabel.text = viewModel.title
        subtitle.text = viewModel.text
    }
}
