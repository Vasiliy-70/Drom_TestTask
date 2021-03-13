//
//  MainListViewController.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 08.03.2021.
//

import UIKit

protocol IMainListViewController: class {
	var cellIdentifier: String { get }
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
		
	}
}

extension MainListViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let number = self.presenter?.viewContent.count
		return number ?? 0
	}

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? MainListCollectionViewCell else {
			assertionFailure("No tableCellView")
			return UICollectionViewCell()
		}
		
		if let url = URL(string: self.presenter?.viewContent[indexPath.row] ?? "") {
					cell.imageView.loadImage(from: url)
				}
		print(indexPath.row)
		return cell as? UICollectionViewCell ?? UICollectionViewCell()
	}
}

extension MainListViewController: IMainListViewController {

	var cellIdentifier: String {
		self.cellId
	}
}

extension MainListViewController: IMainListView {
	func updateData() {
		(self.view as? IMainListViewType)?.updateView()
	}
}

