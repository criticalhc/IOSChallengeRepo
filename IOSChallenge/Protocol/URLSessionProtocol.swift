//
//  URLSessionProtocol.swift
//  IOSChallenge
//
//  Created by Heydon Costello on 17/05/2022.
//

import Foundation

typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

// Allows mocking of the UrlSession
protocol URLSessionProtocol {
    func dataTask(with: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

