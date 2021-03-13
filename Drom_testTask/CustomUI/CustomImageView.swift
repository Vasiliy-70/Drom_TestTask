//
//  CustomImageView.swift
//  Drom_testTask
//
//  Created by Боровик Василий on 13.03.2021.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
	var task: URLSessionTask?
	private var spinner = UIActivityIndicatorView(style: .large)
	
	func loadImage(from url: URL) {
		self.image = nil
		self.addSpinner()
		
		if let task = task {
			task.cancel()
		}
		
		if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
			self.image = imageFromCache
			self.removeSpinner()
			return
		}

		task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
			guard let data = data,
				  let newImage = UIImage(data: data)
			else {
				return
			}
			
			imageCache.setObject(newImage, forKey: url.absoluteString as AnyObject)
			
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				self.image = newImage
				self.removeSpinner()
			}
		}

		self.task?.resume()
	}

	private func addSpinner() {
		self.addSubview(self.spinner)
		
		self.spinner.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			self.spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
			self.spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor)
		])
		
		self.spinner.startAnimating()
	}
	
	private func removeSpinner() {
		self.spinner.removeFromSuperview()
	}
}
