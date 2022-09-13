//
//  BookyApp.swift
//  Booky
//
//  Created by Evangelos Spyromilios on 13.09.22.
//

import SwiftUI

@main
struct BookyApp: App {
    var body: some Scene {
        WindowGroup {
			ContentView().environmentObject(Library())
        }
    }
}
