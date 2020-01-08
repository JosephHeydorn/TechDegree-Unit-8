//
//  DiaryEntryEdit.swift
//  Unit 8 SwiftUI Version
//
//  Created by Joseph Heydorn on 1/6/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//

import SwiftUI

struct DiaryEntryEdit: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var entryHolder = ""
    
    @Binding var isPresented: Bool
    
    var diaryEntry: Entry
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit your entry")) {
                    TextField("Edit Here", text: $entryHolder)
                        .keyboardType(.default)
                }
                Button(action: {
                    self.diaryEntry.diaryEntry = self.entryHolder
                    try! self.managedObjectContext.save()
                    self.isPresented = false
                }) {
                    Text("Update Entry")
                }
            }.navigationBarTitle("Edit Entry")
        }
        .onAppear {
            self.entryHolder = self.diaryEntry.diaryEntry
        }
    }
}

struct DiaryEntryEdit_Previews: PreviewProvider {
    @Environment(\.managedObjectContext) static var managedObjectContext
    
    static var previews: some View {
        let entry = Entry(context: managedObjectContext)
        entry.diaryEntry = "Hello"
        
        return DiaryEntryEdit(isPresented: .constant(true), diaryEntry: entry)
    }
}
