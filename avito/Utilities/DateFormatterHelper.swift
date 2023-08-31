//
//  DateFormatter.swift
//  avito
//
//  Created by Талгат Лукманов on 31.08.2023.
//

import Foundation

final class DateFormatterHelper {
    static func convertDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let date = dateFormatter.date(from: date)!

        dateFormatter.dateFormat = "d MMM"

        return dateFormatter.string(from: date)
    }
}
