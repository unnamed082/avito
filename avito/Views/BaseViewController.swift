//
//  BaseViewController.swift
//  avito
//
//  Created by Талгат Лукманов on 29.08.2023.
//

import Foundation
import UIKit

class BaseViewController : UIViewController {

    private var loaderViewBackgroundView : UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.zPosition = 10
        view.isHidden = true
        return view
    }()

    private var loaderView : UIActivityIndicatorView = {
        var loaderView = UIActivityIndicatorView(style: .medium)
        loaderView.sizeToFit()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        return loaderView
    }()

    // Mark: override base func

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.view.backgroundColor = .white

        loaderViewBackgroundView.addSubview(loaderView)
        view.addSubview(loaderViewBackgroundView)

        let loaderBgViewPadding: CGFloat = 10

        NSLayoutConstraint.activate([
            loaderViewBackgroundView.widthAnchor.constraint(equalToConstant: loaderView.frame.width + loaderBgViewPadding * 2),
            loaderViewBackgroundView.heightAnchor.constraint(equalToConstant: loaderView.frame.height + loaderBgViewPadding * 2),
            loaderViewBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderViewBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            loaderView.centerXAnchor.constraint(equalTo: loaderViewBackgroundView.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: loaderViewBackgroundView.centerYAnchor)
        ])
    }

    // Mark: internal func

    internal func showLoader() {
        loaderViewBackgroundView.isHidden = false
        loaderView.startAnimating()
    }

    internal func hideLoader() {
        loaderViewBackgroundView.isHidden = true
        loaderView.stopAnimating()
    }

    internal func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
