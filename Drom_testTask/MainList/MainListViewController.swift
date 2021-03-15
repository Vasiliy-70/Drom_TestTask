//
//  MainListViewController.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 08.03.2021.
//

import UIKit

protocol IMainListViewController: class {
	var cellIdentifier: String { get }
	func refreshCollection()
}

protocol IMainListView: class {
//	Interface for Presenter
}

final class MainListViewController: UIViewController{
	var presenter: IMainListPresenter?
	private var cellId = "cellId"
	private var customView: IMainListViewType?
	private var collectionViewCellWidth: CGFloat {
		get {
			self.customView?.collectionViewLayout.frame.width ?? 100
		}
	}
	
	private enum Constants {
		static let cellHorizontalOffset: CGFloat = 10
		static let cellVerticalSpacing: CGFloat = 10
	}
	
	init() {
		super.init(nibName: nil, bundle: nil)
		self.customView = MainListView(viewController: self)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.title = "MainList"
	}
	
	override func loadView() {
		self.view = self.customView as? UIView
	}
}

// MARK: UICollectionViewDelegate

extension MainListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		guard let collectionView = self.customView?.collectionViewLayout else {
			return
		}
		
		if let cell = collectionView.cellForItem(at: indexPath) {
			let cellCoordinate = CGPoint(x: cell.frame.origin.x, y: cell.frame.origin.y)

			if (cell as? MainListCollectionViewCell)?.imageView.image != nil {
				UIView.animate(withDuration: 1.0) {
					cell.frame.origin = CGPoint(x: -self.view.frame.width, y: cellCoordinate.y)
				}
				
				self.presenter?.removeItemAt(index: indexPath.row)
				collectionView.deleteItems(at: [indexPath])
			}
		}
	}
}

// MARK: UICollectionViewDataSource

extension MainListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let number = self.presenter?.viewContent.count
		return number ?? 0
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? MainListCollectionViewCell else {
			assertionFailure("No tableCellView")
			return UICollectionViewCell()
		}
		
		if let url = URL(string: self.presenter?.viewContent[indexPath.row] ?? "") {
			cell.imageView.loadImage(from: url)
		}
		
		return cell as? UICollectionViewCell ?? UICollectionViewCell()
	}
}

// MARK: UICollectionViewDelegateFlowLayout

extension MainListViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		
		return CGSize(width: self.collectionViewCellWidth - Constants.cellHorizontalOffset, height: self.collectionViewCellWidth)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		Constants.cellVerticalSpacing
	}
}

//MARK: IMainListViewController

extension MainListViewController: IMainListViewController {
	func refreshCollection() {
		self.presenter?.reloadData()
	}
	
	var cellIdentifier: String {
		self.cellId
	}
}

// MARK: IMainListView

extension MainListViewController: IMainListView {
	
}
