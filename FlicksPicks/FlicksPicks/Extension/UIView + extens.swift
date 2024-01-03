//
//  UIView + extens.swift
//  FlicksPicks
//
//  Created by User on 03.01.2024.
//

import UIKit

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach { view in
            addSubview(view)
        }
    }
}
