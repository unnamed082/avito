//
//  AnnouncementList.swift
//  avito
//
//  Created by Талгат Лукманов on 26.08.2023.
//

import Foundation

struct Advertisements: Codable {
    let advertisements: [Advertisement]
}

struct Advertisement: Codable {
    let id : String
    let title: String
    let price: String
    let location: String
    let imageURL: String
    var imageData : Data?
    let createdDate: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, location
        case imageURL = "image_url"
        case createdDate = "created_date"
    }
}
