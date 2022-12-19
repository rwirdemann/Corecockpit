//
//  CreateExcerciseView.swift
//  Fitnesscockpit
//
//  Created by Ralf Wirdemann on 18.12.22.
//

import SwiftUI
import CoreData

struct CreateExcerciseView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.name, ascending: false)],
        predicate: NSPredicate(format: "phase == 'Warmup'"),
        animation: .default)
    private var warmups: FetchedResults<Activity>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.name, ascending: true)],
        predicate: NSPredicate(format: "phase == 'Workout'"),
        animation: .default)
    private var workouts: FetchedResults<Activity>

    @State private var warmup1: Activity?
    @State private var warmup2: Activity?
    @State private var warmup3: Activity?

    @State private var workout1: Activity?
    @State private var workout2: Activity?
    @State private var workout3: Activity?
    @State private var workout4: Activity?
    @State private var workout5: Activity?
    @State private var workout6: Activity?

    fileprivate func activityPicker(activity: Binding<Activity?>, activities: FetchedResults<Activity>) -> some View {
        return Picker("Activity", selection: activity) {
            Text("Select").tag("nil as Int?")
            
            ForEach(activities) { activity in
                Text(activity.name!)
                    .tag(Optional(activity))
            }
        }
        .labelsHidden()
    }
    
    var body: some View {
        Form {
            Section(header: Text("Warmup")) {
                activityPicker(activity: $warmup1, activities: warmups)
                activityPicker(activity: $warmup2, activities: warmups)
                activityPicker(activity: $warmup3, activities: warmups)
            }
            Section(header: Text("Workout")) {
                activityPicker(activity: $workout1, activities: workouts)
                activityPicker(activity: $workout2, activities: workouts)
                activityPicker(activity: $workout3, activities: workouts)
                activityPicker(activity: $workout4, activities: workouts)
                activityPicker(activity: $workout5, activities: workouts)
                activityPicker(activity: $workout6, activities: workouts)
            }
        }
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Save", action : save)
            }
        }
    }
    
    private func save() {
        let excercise = Excercise(context: context)
        excercise.when = Date()
        guard let w1 = warmup1 else {
            return
        }
        guard let w2 = warmup2 else {
            return
        }
        guard let w3 = warmup3 else {
            return
        }
        guard let wout1 = workout1 else {
            return
        }
        guard let wout2 = workout2 else {
            return
        }
        guard let wout3 = workout3 else {
            return
        }
        guard let wout4 = workout4 else {
            return
        }
        guard let wout5 = workout5 else {
            return
        }
        guard let wout6 = workout6 else {
            return
        }
        excercise.addToWarmups([w1, w2, w3])
        excercise.addToWorkouts([wout1, wout2, wout3, wout4, wout5, wout6])
        try! context.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct CreateExcerciseView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExcerciseView()
    }
}
