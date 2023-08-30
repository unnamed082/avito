//
//  BaseViewController.swift
//  avito
//
//  Created by Талгат Лукманов on 29.08.2023.
//

import Foundation
import UIKit

class BaseViewController : UIViewController {

    private var loaderView : UIActivityIndicatorView = {
        var loaderView = UIActivityIndicatorView(style: .medium)
        loaderView.sizeToFit()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        loaderView.layer.zPosition = 10
        loaderView.isHidden = true
        return loaderView
    }()

    // Mark: override base func

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.view.backgroundColor = .white
        view.addSubview(loaderView)

        NSLayoutConstraint.activate([

            loaderView.widthAnchor.constraint(equalToConstant: loaderView.frame.width),
            loaderView.heightAnchor.constraint(equalToConstant: loaderView.frame.height),
            loaderView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    // Mark: internal func

    internal func showLoader() {
        loaderView.isHidden = false
        loaderView.startAnimating()
    }

    internal func hideLoader() {
        loaderView.isHidden = true
        loaderView.stopAnimating()
    }

    internal func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
