//
//  ActivityIndicatorView.swift
//  NYTimes
//
//  Created by Bhaskar on 16/12/20.
//  Copyright © 2020 Xebia. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorView {
    var view: UIView!

    var activityIndicator: UIActivityIndicatorView!

    var title: String!

    init(title: String, center: CGPoint, width: CGFloat = 300.0, height: CGFloat = 50.0) {
        self.title = title

        let x = center.x - width/2.0
        let y = center.y - height/2.0

        self.view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
        self.view.backgroundColor = UIColor.navigationBarBackgroundColor
        self.view.layer.cornerRadius = 10

        self.activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        self.activityIndicator.color = .white
        self.activityIndicator.hidesWhenStopped = false

        let titleLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 300, height: 50))
        titleLabel.text = title
        titleLabel.textColor = UIColor.white

        self.view.addSubview(self.activityIndicator)
        self.view.addSubview(titleLabel)
    }

    func getViewActivityIndicator() -> UIView {
        return self.view
    }

    func startAnimating() {
        self.activityIndicator.startAnimating()
    }

    func stopAnimating() {
        self.activityIndicator.stopAnimating()
        self.view.removeFromSuperview()
    }
}
