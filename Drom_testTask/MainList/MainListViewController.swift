//
//  MainListViewController.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 08.03.2021.
//

import UIKit

protocol IMainListViewController: class {
	var cellIdentifier: String { get }
	func refresh()
}

protocol IMainListView: class {
	func updateData()
}

final class MainListViewController: UIViewController{
	var presenter: IMainListPresenter?

	
	internal var cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.title = "MainList"
    }
	
	override func loadView() {
		self.view = MainListView(viewController: self)
	}
}

extension MainListViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	
		guard let collectionView = (self.view as? IMainListViewType)?.uiCollectionView else {
			return
		}
	
		let cell = collectionView.cellForItem(at: indexPath)
		
		if (cell as? MainListCollectionViewCell)?.imageView.image != nil {
			UIView.animate(withDuration: 1.0) {
				cell?.frame.origin = CGPoint(x: -500, y: 0)
			}
			
			self.presenter?.removeItemAt(index: indexPath.row)
			collectionView.deleteItems(at: [indexPath])
		}
	}
}

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

extension MainListViewController: IMainListViewController {
	func refresh() {
		self.presenter?.reloadData()
	}
	
	var cellIdentifier: String {
		self.cellId
	}
}

extension MainListViewController: IMainListView {
	func updateData() {
//		(self.view as? IMainListViewType)?.updateView()
	}
}
