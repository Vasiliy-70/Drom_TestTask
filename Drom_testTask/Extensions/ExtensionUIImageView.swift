//
//  ExtensionUIImageView.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 13.03.2021.
//

import UIKit

extension UIImageView {
	func load(url: URL) {
		DispatchQueue.global(qos: .userInitiated).async {
			[weak self] in
			if let data = try? Data(contentsOf: url) {
				if let image = UIImage(data: data) {
					DispatchQueue.main.async {
						self?.image = image
					}
				}
			}
		}
	}
}
