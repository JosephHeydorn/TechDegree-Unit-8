//
//  ContentView.swift
//  Unit 8 SwiftUI Version
//
//  Created by Joseph Heydorn on 1/3/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Entry.entity(),
                  sortDescriptors: [])
    
    private var entries: FetchedResults<Entry>

    @State var showDiaryEntry = false
    @State var showDiaryEntryEdit = false
    @State var coreLocation = LocationHandler()
    
    var body: some View {
        NavigationView {
            List(entries) { entry in
                NavigationLink(destination: DiaryEntryEdit()) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(entry.diaryEntry)")
                                .font(.headline)
                            Text("Mood: \(entry.mood) - Entered: \(entry.date)")
                                .font(.subheadline)
                            Text("Location: \(entry.location)")
                                .font(.subheadline)
                        }
                    }
                }
//                .onDelete { indexSet in
//                    for index in indexSet {
//                        self.managedObjectContext.delete(self.entries[index])
//                    }
//                }
            }
            .sheet(isPresented: $showDiaryEntry) {
                DiaryEntry().environment(\.managedObjectContext, self.managedObjectContext)
            }
            .navigationBarTitle("Diary Entries")
            .navigationBarItems(trailing: Button(action: {
                self.showDiaryEntry = true
            }, label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
            }))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
