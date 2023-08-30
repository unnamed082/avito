//
//  AnnouncementViewCOntroller.swift
//  avito
//
//  Created by Талгат Лукманов on 24.08.2023.
//

import Foundation
import UIKit

final class AnnouncementViewController: BaseViewController {
    
    private let reuseIdentifier = "Cell"
    
    private var needUpdateData : Bool = true
    
    private var advertisements : [Advertisement] = []

    private var refreshControl : UIRefreshControl = {
        var refreshControl = UIRefreshControl()
        return refreshControl
    }()
    
    private var collectionView : UICollectionView = {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .vertical
        collectionViewLayout.minimumLineSpacing = 10
        collectionViewLayout.minimumInteritemSpacing = 10
        collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // Mark: override base func
    
    override func viewDidLoad() {
        super.viewDidLoad()

        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AnnouncementCell.self, forCellWithReuseIdentifier: self.reuseIdentifier)
        collectionView.refreshControl = refreshControl
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        if (needUpdateData) {
            needUpdateData = false

            updateData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // Mark: private func
    
    private func updateData() {
        showLoader()
        
        loadData { [weak self] advertisements in
            self?.advertisements = advertisements.advertisements
            
            DispatchQueue.main.async {
                self?.hideLoader()
                self?.collectionView.reloadData()

                if (self?.refreshControl.isRefreshing ?? false) {
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    private func loadData(completion: @escaping(Advertisements) -> Void) {
        NetworkService().downloadAdvertisements(completion: { [weak self] result in
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

    @objc func refresh(_ sender: AnyObject) {
        updateData()
    }
}

extension AnnouncementViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return advertisements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AnnouncementCell
        cell.tag = indexPath.row

        let adv = advertisements[indexPath.row]

        cell.setData(adv: adv, loadImage: {
            NetworkService().downloadImage(url: adv.imageURL, completion: {
                [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.advertisements[indexPath.row].imageData = data

                        if (cell.tag == indexPath.row) {
                            cell.setImage(data: data)
                        }

                        break
                    case .failure(let error):
                        var message = ""
                        if let error = error as? LocalizedError {
                            message = error.errorDescription ?? ""
                        }
                        else {
                            message = error.localizedDescription
                        }

                        self?.showAlert(message: message)

                        break
                    }
                }
            })
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailedAdvInfoViewController = DetailedAdvInfoViewController()
        detailedAdvInfoViewController.setData(advId: advertisements[indexPath.row].id)
        navigationController?.pushViewController(detailedAdvInfoViewController, animated: true)
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
