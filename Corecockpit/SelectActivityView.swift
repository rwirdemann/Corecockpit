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

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.name, ascending: true)],
        predicate: NSPredicate(format: "phase == 'Workout'"),
        animation: .default)
    private var workouts: FetchedResults<Activity>

    @Environment(\.dismiss) var dismiss

    @Binding var selectedActivity: Activity?
    
    var selectWarmups: Bool
    
    var body: some View {
        List {
            let activities = selectWarmups ? warmups : workouts
            ForEach(activities) { item in
                VStack(alignment: .leading, spacing: 5) {
                    Text("\(item.name!) (\(item.repititions ?? ""))")
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                    HStack {
                        Text("\(item.bodyPart!)")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                        RubberView(rubber: item.rubber!)
                    }
                }
                .onTapGesture {
                    self.selectedActivity = item
                    dismiss()
                }
            }
        }
        .navigationBarTitle(selectWarmups ? "Select Warmup" : "Select Workout")
    }
}
