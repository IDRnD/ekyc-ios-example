//
//  UIViewController+UIAlertControl.swift
//  eKYCExample
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Presents a temporary alert that dismisses automatically after `seconds`.
    func showAutoDismissAlert(title: String? = nil,
                              message: String,
                              dismissAfter seconds: TimeInterval = 1.0) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    /// Presents a regular alert with a single action button.
    func showAlert(
        title: String?,
        message: String?,
        buttonTitle: String = "OK",
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default) { _ in
            completion?()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
