//
//  MainListAssembly.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 08.03.2021.
//

import UIKit

enum MainListAssembly {
	static func createMainListModule() -> UIViewController {
		let view = MainListViewController()
		let queryService = QueryService()
		let model = MainListData()
		
		let presenter = MainListPresenter(view: view, queryService: queryService, model: model)
		view.presenter = presenter
		return view
	}
}
