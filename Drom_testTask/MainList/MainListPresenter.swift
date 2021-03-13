//
//  MainListPresenter.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 08.03.2021.
//

import UIKit

protocol IMainListPresenter: class {
	func loadImageAt(index: Int) -> UIImage?
	var viewContent: [String] { get }
}

final class MainListPresenter {
	private weak var view: IMainListView?
	private var queryService: IQueryService
	private var model: MainListData
	private var viewModel: [String]
	
	
	init(view: IMainListView, queryService: IQueryService, model: MainListData) {
		self.view = view
		self.queryService = queryService
		self.model = model
		self.viewModel = []
		
		self.initViewData()
	}
}

extension MainListPresenter {
	func initViewData() {
		var count = 0
		for item in model.imagesUrl {
			self.viewModel.append(item)
//			loadDataAt(index: count)
			count += 1
		}
	}
}

// MARK: IMainListPresenter

extension MainListPresenter: IMainListPresenter {
	var viewContent: [String] {
		get {
			self.viewModel
		}
	}
	
	func loadImageAt(index: Int) -> UIImage? {
		var image = UIImage()
		
		guard let url = URL(string: self.model.imagesUrl[index]) else {
			return image
		}
		
		self.queryService.getDataAt(url: url, completion: { (data, error) in
			print(error)
			image = UIImage(data: data) ?? UIImage()
		})
		
		return image
	}
	
	var itemsCount: Int {
		get {
			self.model.imagesUrl.count
		}
	}
}
