//
//  ActivityDetailView.swift
//  Fitnesscockpit
//
//  Created by Ralf Wirdemann on 17.12.22.
//

import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var activity: Activity
    
    var body: some View {
        NavigationView {
            Form {
                if let name = Binding<String>($activity.name) {
                    TextField("Name", text: name)
                }
                if let phase = Binding<String>($activity.phase) {
                    Picker("Phase", selection: phase) {
                        ForEach(Constants.PHASES, id: \.self) {
                            Text($0)
                        }
                    }
                }
                if let repititions = Binding<String>($activity.repititions) {
                    Picker("Repititions", selection: repititions) {
                        ForEach(Constants.REPITITIONS, id: \.self) {
                            Text($0)
                        }
                    }
                }
                if let rubber = Binding<String>($activity.rubber) {
                    Picker("Rubber", selection: rubber) {
                        ForEach(Constants.RUBBER, id: \.self) {
                            Text($0)
                        }
                    }
                }
                if let bodyPart = Binding<String>($activity.bodyPart) {
                    Picker("Body Part", selection: bodyPart) {
                        ForEach(Constants.BODY_PARTS, id: \.self) {
                            Text($0)
                        }
                    }
                }
                if let desc = Binding<String>($activity.desc) {
                    TextEditor(text: desc)
                }

            }
        }
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Save") {
                    try? context.save()
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}
