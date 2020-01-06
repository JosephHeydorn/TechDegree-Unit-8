//
//  DiaryEntry.swift
//  Unit 8 SwiftUI Version
//
//  Created by Joseph Heydorn on 1/3/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//

import SwiftUI

struct DiaryEntry: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    let moodTypes = ["Happy", "Average", "Bad"]
    @State var selectedMoodIndex = 1
    @State var diaryEntry = ""
    @State var date = Date()
    @State var formatter = DateFormatter()
    
    //Location Manager
    @State var coreLocation = LocationHandler()
    @State var locationButtonPressed = false
    
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Write About Your Day")) {
                    TextField("Write Here", text: $diaryEntry)
                        .keyboardType(.default)
                }
                Section(header: Text("How was your Day?")) {
                    Picker(selection: $selectedMoodIndex, label: Text("Moods")) {
                        ForEach(0 ..< moodTypes.count) {
                            Text(self.moodTypes[$0]).tag($0)
                        }
                    }
                    Button(action: {
                        print("Added Location")
                        self.coreLocation.requestLocationOnce()
                        self.locationButtonPressed = true
                    }) {
                        Text("Add Location")
                    }
                }
                Button(action: {
                    guard self.diaryEntry != "" else { return }
                    let newEntry = Entry(context: self.managedObjectContext)
                    newEntry.mood = self.moodTypes[self.selectedMoodIndex]
                    newEntry.diaryEntry = self.diaryEntry
                    self.formatter.dateFormat = "MM-dd-yyyy"
                    newEntry.date = self.formatter.string(from: self.date)
                    
                    //Pulls Location Data if the button was pressed
                    if self.locationButtonPressed == true {
                        newEntry.location = locationHolder
                        self.locationButtonPressed = false
                    } else {
                        locationHolder = ""
                    }
                    do {
                        try self.managedObjectContext.save()
                        print("Entry Saved")
                        self.presentationMode.wrappedValue.dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                }) {
                    Text("Add Entry")
                }.navigationBarTitle("Add Entry")
            }
        }
    }
}

struct DiaryEntry_Previews: PreviewProvider {
    static var previews: some View {
        DiaryEntry()
    }
}
