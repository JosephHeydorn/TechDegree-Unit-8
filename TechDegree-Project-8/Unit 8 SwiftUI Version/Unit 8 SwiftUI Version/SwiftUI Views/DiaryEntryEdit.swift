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
    @Environment(\.presentationMode) private var presentationMode
    
    @State var diaryEntry = ""
    
    @FetchRequest(entity: Entry.entity(),
                  sortDescriptors: [])
    
    private var entries: FetchedResults<Entry>
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit your entry")) {
                    TextField("Edit Here", text: $diaryEntry)
                        .keyboardType(.default)
                }
                Button(action: {
                    guard self.diaryEntry != "" else { return }
                    let newEntry = Entry(context: self.managedObjectContext)
                    newEntry.diaryEntry = self.diaryEntry
                    
                    do {
                        try self.managedObjectContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("Update Entry")
                }
            }.navigationBarTitle("Edit Entry")
        }
    }
}

struct DiaryEntryEdit_Previews: PreviewProvider {
    static var previews: some View {
        DiaryEntryEdit()
    }
}
