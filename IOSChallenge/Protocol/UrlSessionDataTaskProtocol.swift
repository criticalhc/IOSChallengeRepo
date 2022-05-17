//
//  UrlSessionDataTaskProtocol.swift
//  IOSChallenge
//
//  Created by Heydon Costello on 17/05/2022.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}


extension URLSessionDataTask: URLSessionDataTaskProtocol { }
