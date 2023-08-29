//
//  DetailedAdvInfoViewController.swift
//  avito
//
//  Created by Талгат Лукманов on 27.08.2023.
//

import Foundation
import UIKit

final class DetailedAdvInfoViewController : BaseViewController {

    var advId : String = ""
    var advertisement : Advertisement? = nil

    var isFirstLoad : Bool = true

    private var refreshControl : UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        return refreshControl
    }()

    private var scrollView : UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private var imageView : UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .solitude
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
        label.textColor = .blue
        label.isUserInteractionEnabled = true
        return label
    }()

    private var phoneNumberLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 17)
        label.textColor = .blue
        label.isUserInteractionEnabled = true
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

    // Mark: override base func

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        emailLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(emailClicked(_:))))
        phoneNumberLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(phoneNumberClicked(_:))))

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

        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        scrollView.refreshControl = refreshControl
        view.addSubview(scrollView)

        let imageSize = view.frame.width
        let horPadding : CGFloat = 15

        NSLayoutConstraint.activate([
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

    // Mark: private func

     private func loadImage(url : String) {
        NetworkService().downloadImage(url: url, completion: {
            [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    var message = ""
                    if let error = error as? LocalizedError {
                        message = error.errorDescription ?? ""
                    }
                    else {
                        message = error.localizedDescription
                    }

                    self?.showAlert(message: message)
                }
                break
            }
        })
    }

    private func loadAdv() {

        if (isFirstLoad) {
            isFirstLoad = false
            showLoader()
        }

        loadAdv(itemId: advId, completion: { [weak self] advertisement in
            self?.advertisement = advertisement

            DispatchQueue.main.async {
                self?.loadImage(url: advertisement.imageURL)

                self?.titleLabel.text = advertisement.title

                self?.priceLabel.text = advertisement.price

                self?.locationLabel.text = advertisement.location

                self?.emailLabel.text = advertisement.email

                self?.phoneNumberLabel.text = advertisement.phoneNumber

                self?.descriptionLabel.text = advertisement.description

                self?.idLabel.text = "Объявление №\(advertisement.id)"

                self?.createdDateLabel.text = advertisement.createdDate

                self?.hideLoader()

                if (self?.refreshControl.isRefreshing ?? false) {
                    self?.refreshControl.endRefreshing()
                }
            }
        })
    }

    private func loadAdv(itemId: String, completion: @escaping(Advertisement) -> Void) {
        NetworkService().downloadAdvertisement(itemId: itemId, completion: { [weak self] result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                DispatchQueue.main.async {
                    var message = ""
                    if let error = error as? LocalizedError {
                        message = error.errorDescription ?? ""
                    }
                    else {
                        message = error.localizedDescription
                    }

                    self?.showAlert(message: message)
                }
                break
            }
        })
    }

    @objc private func emailClicked(_ sender: UITapGestureRecognizer) {
        if let adv = advertisement,
           let email = adv.email,
           let url = URL(string: "mailto://\(email)"),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
        else {
            showAlert(message: "Не удалось перейти к отправке сообщения")
        }
    }

    @objc private func phoneNumberClicked(_ sender: UITapGestureRecognizer) {
        if let adv = advertisement,
           let phoneNumber = adv.phoneNumber {

            let number = phoneNumber.filter{ !($0.isWhitespace || $0 == "(" || $0 == ")" || $0 == "-") }
            if let url = URL(string: "tel://\(number)"),
               UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
            else {
                showAlert(message: "Не удалось выполнить вызов на указанный номер")
            }
        }
        else {
            showAlert(message: "Не удалось выполнить вызов, так как не указан номер")
        }
    }

    @objc func refresh(_ sender: AnyObject) {
        loadAdv()
    }

    // Mark: internal func

    func setData(advId: String) {
        self.advId = advId

        loadAdv()
    }
}
