//
//  ContentView.swift
//  Birthdays
//
//  Created by Scholar on 7/25/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var friends: [Friend] = [
        Friend(name: "Duke Ursino", birthday: Date(timeIntervalSince1970: 30)),
        Friend(name: "Viola", birthday: Date(timeIntervalSince1970: 27))
    ]//array
    
    var body: some View {
        
        
        
    }//body
    
}//struct


#Preview {
    ContentView()
}
