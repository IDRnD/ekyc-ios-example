//
//  ImageView.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func configureUI() {
        backgroundColor = .systemGray5
        contentMode = .scaleAspectFill
        clipsToBounds = true
        layer.cornerRadius = 8

        translatesAutoresizingMaskIntoConstraints = false
    }
}
