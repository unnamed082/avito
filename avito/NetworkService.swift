//
//  NetworkService.swift
//  avito
//
//  Created by Талгат Лукманов on 26.08.2023.
//

import Foundation

class NetworkService {

    init() { }

    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadAdvertisements(completion: @escaping(Advertisements) -> Void) {
        let url = URL(string: "https://www.avito.st/s/interns-ios/main-page.json")!

        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }

            if let advertisements = try? JSONDecoder().decode(Advertisements.self, from: data) {
                completion(advertisements)
            }
            else {
                print("no data or can't decode")
            }
        }
    }

    func downloadImage(from url: URL, completion: @escaping(Data) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completion(data)
        }
    }
}
