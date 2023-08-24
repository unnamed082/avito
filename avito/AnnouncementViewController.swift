//
//  AnnouncementViewCOntroller.swift
//  avito
//
//  Created by Талгат Лукманов on 24.08.2023.
//

import Foundation
import UIKit

class AnnouncementViewController: UICollectionViewController {

    private let reuseIdentifier = "Cell"

    var allPhotos : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView!.register(AnnouncementCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        allPhotos = ["sw_1", "sw_2", "sw_3", "sw_4", "sw_5", "sw_6", "sw_7", "sw_8", "sw_9", "sw_10", "sw_11", "sw_12", "sw_13", "sw_14", "sw_15", "sw_16"]
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Инициализируем ячейку
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AnnouncementCell

        let text = allPhotos[indexPath.item]

        return cell
    }
}
