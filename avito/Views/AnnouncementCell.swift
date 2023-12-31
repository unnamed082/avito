//
//  AnnouncementCell.swift
//  avito
//
//  Created by Талгат Лукманов on 24.08.2023.
//

import Foundation
import UIKit

final class AnnouncementCell: UICollectionViewCell {
    
    private let imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.backgroundColor = .solitude
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private let locationLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 13)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()
    
    private let createdDateLabel: UILabel = {
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
        
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(createdDateLabel)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    // Mark: private func
    
    private func setupConstraints() {
        let imageSize = frame.width
        let bottomPadding: CGFloat = 20
        
        titleLabel.sizeToFit()
        priceLabel.sizeToFit()
        locationLabel.sizeToFit()
        createdDateLabel.sizeToFit()
        
        let itemsSummaryHeight = imageSize + titleLabel.frame.height + priceLabel.frame.height + locationLabel.frame.height + createdDateLabel.frame.height
        let marginBetweenItems = (frame.height - itemsSummaryHeight - bottomPadding) / 4
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalToConstant: imageSize),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: marginBetweenItems),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: marginBetweenItems),
            priceLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: marginBetweenItems),
            locationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            locationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            
            createdDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: marginBetweenItems),
            createdDateLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            createdDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    // Mark: internal func
    
    func setImage(data: Data) {
        imageView.image = UIImage(data: data)
    }
    
    func setData(adv: Advertisement, loadImage: @escaping() -> Void) {
        if let imageData = adv.imageData {
            setImage(data: imageData)
        } else {
            loadImage()
        }
        
        titleLabel.text = adv.title
        
        priceLabel.text = adv.price
        priceLabel.isHidden = priceLabel.text?.isEmpty ?? true
        
        locationLabel.text = adv.location
        locationLabel.isHidden = locationLabel.text?.isEmpty ?? true
        
        createdDateLabel.text = DateFormatterHelper.convertDate(date: adv.createdDate)
        createdDateLabel.isHidden = createdDateLabel.text?.isEmpty ?? true
        
        setupConstraints()
    }
}
