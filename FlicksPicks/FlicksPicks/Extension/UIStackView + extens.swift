//
//  UIStackView + extens.swift
//  FlicksPicks
//
//  Created by User on 15.01.2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        views.forEach { view in
            addArrangedSubview(view)
        }
    }
}
