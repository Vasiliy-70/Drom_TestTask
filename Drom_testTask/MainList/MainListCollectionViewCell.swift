//
//  MainListCollectionViewCell.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 08.03.2021.
//

import UIKit

final class MainListCollectionViewCell: UICollectionViewCell {
	var imageView = CustomImageView(queryService: QueryService())
	
	private enum Constraints {
		static let imageHorizontalOffset: CGFloat = 5
		static let imageVerticalOffset: CGFloat = 5
	}
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		
		self.setupView()
		self.setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

private extension MainListCollectionViewCell {
	func setupView() {
		self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
		self.imageView.contentMode = .scaleToFill
	}
}

// MARK: SetupConstraints

private extension MainListCollectionViewCell {
	func setupConstraints() {
		self.setupImageConstraints()
	}
	
	func setupImageConstraints() {
		self.contentView.addSubview(self.imageView)
		self.imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			self.imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constraints.imageVerticalOffset),
			self.imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: Constraints.imageHorizontalOffset),
			self.imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -Constraints.imageHorizontalOffset),
			self.imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -Constraints.imageVerticalOffset)
		])
	}
}
