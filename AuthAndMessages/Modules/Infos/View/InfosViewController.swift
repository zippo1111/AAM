//
//  InfosViewController.swift
//  AuthAndMessages
//
//  Created by Mangust on 16.05.2025.
//

import UIKit

final class InfosViewController: UIViewController {
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Server sort", "By date sort"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(sortChanged(_:)), for: .valueChanged)
        control.selectedSegmentTintColor = UIColor(red: 0.43, green: 0.61, blue: 0.81, alpha: 1.00)
        return control
    }()
    private var dataSource: UICollectionViewDiffableDataSource<Section, InfoViewModel>!
    private var viewModelData: [InfoViewModel]? {
        didSet {
            initialViewModelData = viewModelData
            refreshCollection()
        }
    }
    private var initialViewModelData: [InfoViewModel]?
    private let collectionView = InfosCollectionView()
    private let spinner = UIActivityIndicatorView()
    private let viewModel: InfosViewModel?
    private let dateFormatter: DateFormatterHelperProtocol

    init(viewModel: InfosViewModel?, dateFormatter: DateFormatterHelperProtocol) {
        self.viewModel = viewModel
        self.dateFormatter = dateFormatter
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

        loadData()
    }

    private func setupNavigation() {
        navigationItem.title = "Dev exam"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Constants.refreshIcon,
            style: .plain,
            target: self,
            action: #selector(refreshCollection)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.tintColor = .black
    }

    private func setupViews() {
        view.addSubview(segmentedControl)
        view.addSubview(collectionView)
        view.addSubview(spinner)

        collectionView.delegate = self
    }

    private func configureViews() {
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.centerX.equalToSuperview()
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(10)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
        }

        spinner.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func setupCollection() {
        guard let viewModelData = viewModelData else {
            return
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, InfoViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModelData, toSection: .main)

        dataSource = UICollectionViewDiffableDataSource<Section, InfoViewModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in

            guard let cell = (collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: InfoCell.self),
                for: indexPath
            ) as? InfoCell) else {
                return UICollectionViewCell()
            }

            cell.configure(viewModel: item, row: indexPath.row)

            return cell
        })

        collectionView.dataSource = dataSource
        dataSource.applySnapshotUsingReloadData(snapshot)

        Task {
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }

    private func loadData() {
        spinner.startAnimating()

        Task {
            guard let data = await viewModel?.fetchData() else {
                return
            }

            viewModelData = data
        }
    }

    private func goDetails(at row: Int) {
        let detailViewController = DetailedInfoViewController(viewModel: viewModelData?[row])

        if let nav = navigationController {
            nav.pushViewController(detailViewController, animated: true)
        } else {
            present(detailViewController, animated: true, completion: nil)
        }
    }

    @objc
    private func refreshCollection() {
        collectionView.configure(
            viewModelData: viewModelData
        )

        setupCollection()

        if spinner.isAnimating {
            spinner.stopAnimating()
        }
    }

    @objc func sortChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewModelData = initialViewModelData
            refreshCollection()
        case 1:
            viewModelData = viewModelData?.sortedByDateDescending(dateFormatter)
            refreshCollection()
        default:
            break
        }
    }
}

extension InfosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goDetails(at: indexPath.row)
    }
}

fileprivate extension InfosViewController {
    enum Constants {
        static let refreshIcon = UIImage(systemName: "arrow.triangle.2.circlepath")
    }
}
