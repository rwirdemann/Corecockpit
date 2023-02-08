//
//  SelectActivityView.swift
//  Corecockpit
//
//  Created by Ralf Wirdemann on 07.02.23.
//

import SwiftUI

struct SelectActivityView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.name, ascending: true)],
        predicate: NSPredicate(format: "phase == 'Warmup'"),
        animation: .default)
    private var warmups: FetchedResults<Activity>
    
    @Environment(\.dismiss) var dismiss

    @Binding var selectedActivity: Activity?
    
    var body: some View {
        List {
            ForEach(warmups) { item in
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(item.name!) (\(item.repititions ?? ""))")
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    Text("\(item.phase!) - \(item.bodyPart!)")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                .onTapGesture {
                    self.selectedActivity = item
                    dismiss()
                }
            }
        }
    }
}
