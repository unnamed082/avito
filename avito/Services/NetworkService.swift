//
//  NetworkService.swift
//  avito
//
//  Created by Талгат Лукманов on 26.08.2023.
//

import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    // Другие возможные ошибки

    public var errorDescription: String? {
        switch self {
        case .invalidURL: return NSLocalizedString("Некорректный url адрес", comment: "Некорректный url адрес")
        case .invalidResponse: return NSLocalizedString("Ошибка при выполнении запроса", comment: "Ошибка при выполнении запроса")
        }
    }
}

public enum ParseError: Error, LocalizedError {
    case invalidData
    // Другие возможные ошибки

    public var errorDescription: String? {
        switch self {
        case .invalidData: return NSLocalizedString("Получены неправильные данные", comment: "Получены неправильные данные")
        }
    }
}

class NetworkService {

    init() { }

    private func fetchData(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200,
                  let data = data else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            completion(.success(data))
        }

        task.resume()
    }

    func downloadImage(url: String, completion: @escaping(Result<Data, Error>) -> Void) {
        fetchData(url: url, completion: completion)
    }

    func downloadData<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void) {
        fetchData(url: url) { result in
            switch result {
            case .success(let data):
                if let resultData = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(resultData))
                } else {
                    completion(.failure(ParseError.invalidData))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func downloadAdvertisement(itemId: String, completion: @escaping(Result<Advertisement, Error>) -> Void) {
        let url = "https://www.avito.st/s/interns-ios/details/\(itemId).json"
        downloadData(url: url, completion: completion)
    }

    func downloadAdvertisements(completion: @escaping(Result<Advertisements, Error>) -> Void) {
        let url = "https://www.avito.st/s/interns-ios/main-page.json"
        downloadData(url: url, completion: completion)
    }
}
