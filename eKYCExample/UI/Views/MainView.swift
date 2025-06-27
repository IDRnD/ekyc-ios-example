//
//  MainView.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import UIKit

class MainView: UIView {
    // MARK: - UI Components
    let captureSelfieButton = Button(title: "Capture Face", backgroundColor: .systemBlue)
    let captureDocumentButton = Button(title: "Capture Document", backgroundColor: .systemGreen)
    let enrollButton = Button(title: "Perform Request", backgroundColor: .systemPurple)
    
    let selfieImageView = ImageView()
    let documentImageView = ImageView()
    
    lazy var selfieStackView = StackView([captureSelfieButton, selfieImageView])
    lazy var documentStackView = StackView([captureDocumentButton, documentImageView], axis: .horizontal)
    lazy var contentStackView = StackView([selfieStackView, documentStackView], axis: .vertical)
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    func setupUI() {
        backgroundColor = .systemBackground
        
        // Add subviews
        addSubview(contentStackView)
        addSubview(enrollButton)
        
        let padding: CGFloat = 32.0
        let height: CGFloat = 60.0
        
        // Auto Layout constraints
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        enrollButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            contentStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            
            enrollButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            enrollButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            enrollButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
            enrollButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            enrollButton.heightAnchor.constraint(equalToConstant: height)
        ])
        
        selfieImageView.widthAnchor.constraint(equalToConstant: height).isActive = true
        selfieImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        documentImageView.widthAnchor.constraint(equalToConstant: height).isActive = true
        documentImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        // Set initial button state
        enrollButton.isEnabled = false
    }
}
