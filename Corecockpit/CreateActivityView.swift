//
//  CreateSessionView.swift
//  Fitnesscockpit
//
//  Created by Ralf Wirdemann on 17.12.22.
//

import SwiftUI

struct CreateActivityView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var desc = ""
    @State private var phase = Constants.PHASES[0]
    @State private var bodyPart = Constants.BODY_PARTS[0]
    @State private var repititions = Constants.REPITITIONS[0]
    @State private var rubber = Constants.RUBBER[0]

    var body: some View {
        Form {
            TextField("Name", text: $name)
            Picker("Phase", selection: $phase) {
                ForEach(Constants.PHASES, id: \.self) {
                    Text($0)
                }
            }
            Picker("Repititions", selection: $repititions) {
                ForEach(Constants.REPITITIONS, id: \.self) {
                    Text($0)
                }
            }
            Picker("Rubber", selection: $rubber) {
                ForEach(Constants.RUBBER, id: \.self) {
                    Text($0)
                }
            }
            Picker("Body Part", selection: $bodyPart) {
                ForEach(Constants.BODY_PARTS, id: \.self) {
                    Text($0)
                }
            }
            TextEditor(text: $desc)
        }
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Save", action : save)
                    .disabled(self.name == "")
            }
        }
    }
    
    private func save() {
        let activity = Activity(context: context)
        activity.name = name
        activity.phase = phase
        activity.repititions = repititions
        activity.rubber = rubber
        activity.bodyPart = bodyPart
        activity.desc = desc
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}
