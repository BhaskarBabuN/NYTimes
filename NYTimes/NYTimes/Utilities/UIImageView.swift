//
//  UIImageView.swift
//  NYTimes
//
//  Created by Bhaskar on 16/12/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageUsingCache(withUrl urlString : String) {
        guard let url = URL(string: urlString) else { return }

        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
        addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.center = self.center

        // if not, download image from url
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self](data, response, error) in
            if error != nil {
                print(error!)
                DispatchQueue.main.async {
                    activityIndicator.removeFromSuperview()
                }
                return
            }
            guard let contentData = data else {
                print("Data not found")
                return
            }
            DispatchQueue.main.async { [weak self] in
                if let image = UIImage(data: contentData) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self?.image = image
                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
}
