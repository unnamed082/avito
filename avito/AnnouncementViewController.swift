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

    private var loaderViewBackgroundView : UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.isHidden = true
        return view
    }()

    private var loaderView : UIActivityIndicatorView = {
        var loaderView = UIActivityIndicatorView(style: .medium)
        loaderView.sizeToFit()
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        return loaderView
    }()

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

        loaderViewBackgroundView.addSubview(loaderView)
        view.addSubview(loaderViewBackgroundView)

        let loaderBgViewPadding: CGFloat = 10
        NSLayoutConstraint.activate([
            loaderViewBackgroundView.widthAnchor.constraint(equalToConstant: loaderView.frame.width + loaderBgViewPadding * 2),
            loaderViewBackgroundView.heightAnchor.constraint(equalToConstant: loaderView.frame.height + loaderBgViewPadding * 2),
            loaderViewBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loaderViewBackgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            loaderView.centerXAnchor.constraint(equalTo: loaderViewBackgroundView.centerXAnchor),
            loaderView.centerYAnchor.constraint(equalTo: loaderViewBackgroundView.centerYAnchor)
        ])
    }

    //Mark: base func

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)

        if (needUpdateData) {
            updateData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func updateData() {
        showLoader()

        loadData { advertisements in
            self.advertisements = advertisements.advertisements

            DispatchQueue.main.async {
                self.hideLoader()
                self.collectionView.reloadData()
            }
        }
    }

    private func loadData(completion: @escaping(Advertisements) -> Void) {
        NetworkService().downloadAdvertisements(completion: { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                DispatchQueue.main.async {
                    var message = ""
                    if let error = error as? LocalizedError {
                        message = error.errorDescription!
                    }
                    else {
                        message = error.localizedDescription
                    }

                    self.showAlert(message: message)
                }
                break
            }
        })
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    private func showLoader() {
        loaderViewBackgroundView.isHidden = false
        loaderView.startAnimating()
    }

    private func hideLoader() {
        loaderViewBackgroundView.isHidden = true
        loaderView.stopAnimating()
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
        cell.tag = indexPath.row
        cell.showError = { message in
            self.showAlert(message: message)
        }

        cell.setData(adv: advertisements[indexPath.row],
                     imageDataUploaded: { imageData in
            self.advertisements[indexPath.row].imageData = imageData

            if (cell.tag == indexPath.row) {
                cell.setImage(data: imageData)
            }
        })
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

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
