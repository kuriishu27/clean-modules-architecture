//
//  UIViewController+make.swift
//  MoviesSearch
//
//  Created by Oleh Kudinov on 29/09/2020.
//

import UIKit

public extension UITableViewController {

    public func makeActivityIndicator(size: CGSize) -> UIActivityIndicatorView {
        let style: UIActivityIndicatorView.Style = .medium

        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: size)

        return activityIndicator
    }
}
