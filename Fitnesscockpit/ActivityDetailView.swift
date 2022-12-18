//
//  EditActivityView.swift
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
