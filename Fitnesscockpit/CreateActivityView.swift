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
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
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
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        presentationMode.wrappedValue.dismiss()
    }
}
