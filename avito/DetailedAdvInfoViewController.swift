//
//  DetailedAdvInfoViewController.swift
//  avito
//
//  Created by Талгат Лукманов on 27.08.2023.
//

import Foundation
import UIKit

final class DetailedAdvInfoViewController : UIViewController {

    private var scrollView : UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private var imageView : UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = UIColor(red: 215/255, green: 222/255, blue: 230/255, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var titleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private var priceLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()

    private var locationLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private var emailLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private var phoneNumberLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        return label
    }()

    private var descriptionTitleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 17)
        label.text = "Описание товара:"
        return label
    }()

    private var descriptionLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 0
        return label
    }()

    private var idLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()

    private var createdDateLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        return label
    }()

    private var loaderViewBackgroundView : UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.isHidden = true
        return view
    }()

    private var loaderView : UIActivityIndicatorView = {
        var loaderView = UIActivityIndicatorView(style: .medium)
        loaderView.sizeToFit()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        return loaderView
    }()

    override func viewDidLoad() {
        view.backgroundColor = .white

        view.addSubview(scrollView)

        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(locationLabel)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(phoneNumberLabel)
        scrollView.addSubview(descriptionTitleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(idLabel)
        scrollView.addSubview(createdDateLabel)

        loaderViewBackgroundView.addSubview(loaderView)
        view.addSubview(loaderViewBackgroundView)

        let loaderBgViewPadding: CGFloat = 10
        let imageSize = view.frame.width
        let horPadding : CGFloat = 15

        NSLayoutConstraint.activate([
            loaderViewBackgroundView.widthAnchor.constraint(equalToConstant: loaderView.frame.width + loaderBgViewPadding * 2),
            loaderViewBackgroundView.heightAnchor.constraint(equalToConstant: loaderView.frame.height + loaderBgViewPadding * 2),
            loaderViewBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderViewBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            loaderView.centerXAnchor.constraint(equalTo: loaderViewBackgroundView.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: loaderViewBackgroundView.centerYAnchor),

            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: horPadding),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -horPadding),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: horPadding),
            priceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -horPadding),

            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 15),
            locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: horPadding),
            locationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -horPadding),

            emailLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: horPadding),
            emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -horPadding),

            phoneNumberLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            phoneNumberLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: horPadding),
            phoneNumberLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -horPadding),

            descriptionTitleLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 10),
            descriptionTitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: horPadding),
            descriptionTitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -horPadding),

            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 3),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: horPadding),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -horPadding),

            idLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            idLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: horPadding),
            idLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -horPadding),

            createdDateLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 5),
            createdDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: horPadding),
            createdDateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -horPadding),
        ])

        view.layoutIfNeeded()

        scrollView.contentSize = CGSize(width: view.frame.width, height: createdDateLabel.frame.maxY)
    }

    private func showLoader() {
        loaderViewBackgroundView.isHidden = false
        loaderView.startAnimating()
    }

    private func hideLoader() {
        loaderViewBackgroundView.isHidden = true
        loaderView.stopAnimating()
    }

    private func loadImage(url : String) {
        NetworkService().downloadImage(url: url, completion: {
            result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data)
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    var message = ""
                    if let error = error as? LocalizedError {
                        message = error.errorDescription!
                    }
                    else {
                        message = error.localizedDescription
                    }

                    self.showAlert(message: message)
                }
                break
            }
        })
    }

    private func loadAdv(itemId: String, completion: @escaping(Advertisement) -> Void) {
        NetworkService().downloadAdvertisement(itemId: itemId, completion: { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                DispatchQueue.main.async {
                    var message = ""
                    if let error = error as? LocalizedError {
                        message = error.errorDescription!
                    }
                    else {
                        message = error.localizedDescription
                    }

                    self.showAlert(message: message)
                }
                break
            }
        })
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func setData(advId: String) {

        showLoader()

        loadAdv(itemId: advId, completion: { advertisement in
            DispatchQueue.main.async {
                self.loadImage(url: advertisement.imageURL)

                self.titleLabel.text = advertisement.title

                self.priceLabel.text = advertisement.price

                self.locationLabel.text = advertisement.location

                self.emailLabel.text = advertisement.email

                self.phoneNumberLabel.text = advertisement.phoneNumber

                self.descriptionLabel.text = advertisement.description

                self.idLabel.text = "Объявление №\(advertisement.id)"

                self.createdDateLabel.text = advertisement.createdDate

                self.hideLoader()
            }
        })
    }
}