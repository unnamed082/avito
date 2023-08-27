//
//  AnnouncementCell.swift
//  avito
//
//  Created by Талгат Лукманов on 24.08.2023.
//

import Foundation
import UIKit

class AnnouncementCell: UICollectionViewCell {

    private var imageView : UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var contentStackView : UIStackView = {
        var stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private var titleLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()

    private var priceLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private var locationLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()

    private var createdDateLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(priceLabel)
        contentStackView.addArrangedSubview(locationLabel)
        contentStackView.addArrangedSubview(createdDateLabel)

        addSubview(imageView)
        addSubview(contentStackView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        let imageSize = frame.width

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),

            contentStackView.leftAnchor.constraint(equalTo: leftAnchor),
            contentStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            contentStackView.rightAnchor.constraint(equalTo: rightAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func setImage(data : Data) {
        imageView.image = UIImage(data: data)
        // todo изображение не обрезается
    }

    func setData(adv: Advertisement, imageDataUploaded: @escaping(Data) -> Void)
    {
        if let imageData = adv.imageData {
            setImage(data: imageData)
        }
        else
        {
            NetworkService().downloadImage(from: URL(string: adv.imageURL)!, completion: { imageData in
                DispatchQueue.main.async {
                    imageDataUploaded(imageData)
                }

            })
        }

        titleLabel.text = adv.title
        priceLabel.text = adv.price

        priceLabel.isHidden = priceLabel.text?.isEmpty ?? true

        locationLabel.text = adv.location
        locationLabel.isHidden = locationLabel.text?.isEmpty ?? true

        createdDateLabel.text = adv.createdDate // todo convert date time format
        createdDateLabel.isHidden = createdDateLabel.text?.isEmpty ?? true
    }
}
