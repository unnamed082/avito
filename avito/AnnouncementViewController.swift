//
//  AnnouncementViewCOntroller.swift
//  avito
//
//  Created by Талгат Лукманов on 24.08.2023.
//

import Foundation
import UIKit

class AnnouncementViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let reuseIdentifier = "Cell"

    var allPhotos : [String] = []

    init() {
        var collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10

        super.init(collectionViewLayout: collectionViewLayout)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout

        let space = flowLayout?.minimumInteritemSpacing ?? 0.0

        let itemWidth = (collectionView.frame.size.width - space) / 2.0

        return CGSize(width: itemWidth, height: itemWidth * 1.5) // todo сделать обсчет высоты конкретного элемента
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Инициализируем ячейку
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AnnouncementCell

        let text = allPhotos[indexPath.item]

        return cell
    }
}
