//
//  MainListCollectionViewCell.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 08.03.2021.
//

import UIKit

final class MainListCollectionViewCell: UICollectionViewCell {
	var imageView = CustomImageView()
	
	private lazy var width: NSLayoutConstraint = {
		let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
		width.isActive = true
		return width
	}()
	
	private enum Constraints {
		static let imageHorizontalOffset: CGFloat = 10
		static let imageVerticalOffset: CGFloat = 10
		static let imageHeight: CGFloat = 400
		
		static let contentViewOffset: CGFloat = 5
	}
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		
		self.setupView()
		self.setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
		self.width.constant = self.bounds.size.width
		return self.contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
	}
}

private extension MainListCollectionViewCell {
	func setupView() {
		self.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
		self.imageView.contentMode = .scaleAspectFill
	}
}

// MARK: SetupConstraints

extension MainListCollectionViewCell {
	func setupConstraints() {
		self.setupImageConstraints()
		self.setupContentViewConstraints()
	}
	
	func setupImageConstraints() {
		self.contentView.addSubview(self.imageView)
		self.imageView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: Constraints.imageVerticalOffset),
			self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: Constraints.imageHorizontalOffset),
			self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -Constraints.imageHorizontalOffset),
			self.imageView.heightAnchor.constraint(equalTo: self.contentView.widthAnchor),
//			self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
		])
	}
	
	func setupContentViewConstraints() {
		self.contentView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			self.contentView.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: Constraints.imageVerticalOffset)
		])
	}
}
