//
//  AnnouncementCell.swift
//  avito
//
//  Created by Талгат Лукманов on 24.08.2023.
//

import Foundation
import UIKit

final class AnnouncementCell: UICollectionViewCell {

    private var imageView : UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .solitude
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
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
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()

    private var priceLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()

    private var locationLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()

    private var createdDateLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()

    // Mark: override base func

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(priceLabel)
        contentStackView.addArrangedSubview(locationLabel)
        contentStackView.addArrangedSubview(createdDateLabel)

        contentView.addSubview(imageView)
        contentView.addSubview(contentStackView)
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

    override func prepareForReuse() {
        imageView.image = nil
    }

    // Mark: private func

    private func convertDate(dateString : String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let date = dateFormatter.date(from: dateString)!

        dateFormatter.dateFormat = "d MMM"

        return dateFormatter.string(from: date)
    }

    // Mark: internal func

    func setImage(data : Data) {
        imageView.image = UIImage(data: data)
    }

    func setData(adv: Advertisement, loadImage: @escaping() -> Void)
    {
        if let imageData = adv.imageData {
            setImage(data: imageData)
        }
        else {
            loadImage()
        }

        titleLabel.text = adv.title

        priceLabel.text = adv.price
        priceLabel.isHidden = priceLabel.text?.isEmpty ?? true

        locationLabel.text = adv.location
        locationLabel.isHidden = locationLabel.text?.isEmpty ?? true

        createdDateLabel.text = convertDate(dateString: adv.createdDate)
        createdDateLabel.isHidden = createdDateLabel.text?.isEmpty ?? true
    }
}