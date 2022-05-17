//
//  MainViewController.swift
//  IOSChallenge
//
//  Created by Heydon Costello on 17/05/2022.
//

import Foundation

let dataUrl = URL(string: "https://swapi.dev/api/planets");


public func getPlanetDataFromBackend() async -> PlanetApiResult {
    print("getting data from backend...")
    let planet : PlanetApiResult? = await getData(dataUrl!)
    print("got data from backend")
    return planet!
}
