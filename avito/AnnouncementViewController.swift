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
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

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

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AnnouncementCell

        cell.setData(adv: advertisements[indexPath.row],
        imageDataUploaded: { imageData in
            self.advertisements[indexPath.row].imageData = imageData
        })
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // todo show second VC
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout

        let space = flowLayout?.minimumInteritemSpacing ?? 0.0

        let sectionInsets = flowLayout?.sectionInset ?? UIEdgeInsets.zero
        let horMargins = sectionInsets.left + sectionInsets.right

        let itemWidth = (collectionView.frame.size.width - space - horMargins) / 2.0
        let itemHeight = itemWidth * 1.6

        return CGSize(width: itemWidth, height: itemHeight)
    }
}
