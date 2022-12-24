//
//  ContentView.swift
//  Shared
//
//  Created by Patrick McElroy on 10/5/22.
//

import SwiftUI

struct ContentView: View {
    var defaults = UserDefaults.standard
    var body: some View {
        Text(defaults.string(forKey: "visit_coord") ?? "No visit")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
