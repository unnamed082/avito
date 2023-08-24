//
//  AnnouncementCell.swift
//  avito
//
//  Created by Талгат Лукманов on 24.08.2023.
//

import Foundation
import UIKit

class AnnouncementCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
