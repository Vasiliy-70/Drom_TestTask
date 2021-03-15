//
//  MainListPresenter.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 08.03.2021.
//

protocol IMainListPresenter: class {
	func reloadData()
	func removeItemAt(index: Int)
	var viewContent: [String] { get }
}

final class MainListPresenter {
	private weak var view: IMainListView?
	private var model: MainListData
	private var viewModel = [String]()
	
	init(view: IMainListView, model: MainListData) {
		self.view = view
		self.model = model
		
		self.initViewData()
	}
}

private extension MainListPresenter {
	func initViewData() {
		self.viewModel.removeAll()
		for item in model.imagesUrl {
			self.viewModel.append(item)
		}
	}
}

// MARK: IMainListPresenter

extension MainListPresenter: IMainListPresenter {
	func reloadData() {
		self.initViewData()
	}
	
	func removeItemAt(index: Int) {
		self.viewModel.remove(at: index)
	}
	
	var viewContent: [String] {
		get {
			self.viewModel
		}
	}
}
