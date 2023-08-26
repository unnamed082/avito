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

    private var needUpdateData : Bool = true

    private var advertisements : [Advertisement] = []

    //Mark:  ctor
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
    }

    //Mark: base func

    override func viewWillAppear(_ animated: Bool) {
        if (needUpdateData) {
            updateData()
        }
    }

    private func updateData() {
        loadData { advertisements in
            self.advertisements = advertisements.advertisements

            DispatchQueue.main.async {
//                self.refreshControl.endRefreshing()
                self.collectionView.reloadData()
            }
        }
    }

    private func loadData(completion: @escaping(Advertisements) -> Void) {
        NetworkService().downloadAdvertisements(completion: { advertisements in
            completion(advertisements)
        })
    }

    //Mark: Source, Delegate, FlowLayout
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisements.count
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space = (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0

        let itemWidth = (collectionView.frame.size.width - space) / 2.0
        let itemHeight = itemWidth * 1.6

        return CGSize(width: itemWidth, height: itemHeight) // todo сделать обсчет высоты конкретного элемента
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Инициализируем ячейку
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AnnouncementCell

        return cell
    }
}
