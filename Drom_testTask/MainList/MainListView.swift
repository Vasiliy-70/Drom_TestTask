//
//  MainListView.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 08.03.2021.
//

import UIKit

protocol IMainListViewType: class {
	var collectionViewLayout: UICollectionView { get }
}

final class MainListView: UIView {
	private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
	private let viewController: IMainListViewController
	private var refreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
		return refreshControl
	}()
	
	private enum Constraints {
		static let collectionViewHorizontalOffset: CGFloat = 10
		static let collectionViewVerticalOffset: CGFloat = 10
	}
	
	private enum Constants {
		static let layoutHeight: CGFloat = 1
	}
	
	init(viewController: IMainListViewController) {
		self.viewController = viewController
		super.init(frame: .zero)
		
		self.setupView()
		self.setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: SetupView

private extension MainListView {
	func setupView() {
		self.backgroundColor = .white
		
		self.setupCollectionView()
	}
	
	func setupCollectionView() {
		self.collectionView.backgroundColor = .white
		self.collectionView.isPagingEnabled = false

		self.collectionView.register(MainListCollectionViewCell.self, forCellWithReuseIdentifier: self.viewController.cellIdentifier)
		
		self.collectionView.delegate = self.viewController as? UICollectionViewDelegate
		self.collectionView.dataSource = self.viewController as? UICollectionViewDataSource
		self.collectionView.refreshControl = self.refreshControl
	}
}

// MARK: SetupConstraints

private extension MainListView {
	func setupConstraints() {
		self.setupCollectionViewConstraints()
	}
	
	func setupCollectionViewConstraints() {
		self.addSubview(self.collectionView)
		self.collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			self.collectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.collectionViewVerticalOffset),
			self.collectionView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.collectionViewHorizontalOffset),
			self.collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.collectionViewHorizontalOffset),
			self.collectionView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.collectionViewVerticalOffset)
		])
	}
}

// MARK: IMainListView

extension MainListView: IMainListViewType {
	var collectionViewLayout: UICollectionView {
		self.collectionView
	}
}

// MARK: Action

private extension MainListView {
	@objc func refresh(sender: UIRefreshControl) {
		imageCache.removeAllObjects()
		self.viewController.refreshCollection()
		self.collectionView.reloadData()
		sender.endRefreshing()
	}
}
