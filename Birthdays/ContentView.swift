//
//  ContentView.swift
//  Birthdays
//
//  Created by Scholar on 7/25/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query private var friends: [Friend] = [
        
        //Friend(name: "Viola", birthday: Date(timeIntervalSince1970: 20)),
        //Friend(name: "Olivia", birthday: Date(timeIntervalSince1970: 27))
        
    ]//array
    @Environment(\.modelContext) private var context
    @State private var newName = ""
    @State private var newBirthday = Date.now
    @State private var selectedFriend: Friend?
    
    var body: some View {
        
        NavigationStack {
            
            List {
                
                ForEach(friends) {friend in
                        
                    HStack {
                            
                        Text(friend.name)
                        Spacer()
                        Text(friend.birthday, format: .dateTime.month(.wide).day().year())
                            
                    }//hstack
                    .onTapGesture {
                        
                        selectedFriend = friend
                        
                    }//ontapgesture
                    
                }//foreach
                .onDelete(perform: deleteFriend)
                
            }//list
            .navigationTitle("Birthdays")
            .sheet(item: $selectedFriend) { friend in
                
                NavigationStack {
                    
                    EditFriendView(friend: friend)
                    
                }//navigationstack
                
            }//sheet
            .safeAreaInset(edge: .bottom) {
                
                VStack(alignment: .center, spacing: 20) {
                    
                    Text("New Birthday")
                        .font(.headline)
                    DatePicker(selection: $newBirthday, in: Date.distantPast...Date.now, displayedComponents: .date) {
                        
                        TextField("Name", text: $newName)
                            .textFieldStyle(.roundedBorder)
                        
                    }//datepicker
                    Button("Save") {
                        
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        //friends.append(newFriend)
                        context.insert(newFriend)
                        newName = ""
                        newBirthday = .now
                        
                    }//button
                    .bold()
                    
                }//vstack
                .padding()
                .background(.bar)
                
            }//safeareainset
            
        }//navigationstack
        
    }//body
    
    func deleteFriend(at offsets: IndexSet) {
        
        for index in offsets {
            
            let friendToDelete = friends[index]
            context.delete(friendToDelete)
            
        }//for loop
        
    }//func
    
}//struct


#Preview {
    
    ContentView()
        .modelContainer(for: Friend.self, inMemory: true)
    
}//preview
