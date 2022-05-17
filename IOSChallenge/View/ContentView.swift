//
//  ContentView.swift
//  IOSChallenge
//
//  Created by Heydon Costello on 17/05/2022.
//

import SwiftUI

@MainActor
struct ContentView: View {
    
    @State private var planets : [Planet]
    
    init() {
        planets = [];
    }
    
    var body: some View {
            List(planets) { planet in
                Text(planet.name)
            }
        .task {
            let data = await getPlanetDataFromBackend()
            planets = data.results
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
