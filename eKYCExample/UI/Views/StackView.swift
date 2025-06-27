//
//  StackView.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import UIKit

class StackView: UIStackView {
    init(_ subviews: [UIView], axis: NSLayoutConstraint.Axis = .horizontal, spacing: CGFloat = 16) {
        super.init(frame: .zero)
        self.axis = axis
        self.spacing = spacing
        self.distribution = .fill
        self.translatesAutoresizingMaskIntoConstraints = false
        
        subviews.forEach { addArrangedSubview($0) }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
