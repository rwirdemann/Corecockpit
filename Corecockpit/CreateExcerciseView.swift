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
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.name, ascending: true)],
        predicate: NSPredicate(format: "phase == 'Warmup'"),
        animation: .default)
    private var warmups: FetchedResults<Activity>

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Activity.name, ascending: true)],
        predicate: NSPredicate(format: "phase == 'Workout'"),
        animation: .default)
    private var workouts: FetchedResults<Activity>

    @State private var date = Date()
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
                Text("\(activity.name!)")
                .tag(Optional(activity))
            }
        }
        .pickerStyle(.menu)
        .labelsHidden()
    }
    
    fileprivate func activitySelector(activity: Binding<Activity?>) -> HStack<_ConditionalContent<NavigationLink<Text, SelectActivityView>, NavigationLink<Text, SelectActivityView>>> {
        return HStack {
            if let name = activity.wrappedValue?.name {
                NavigationLink(name, destination: SelectActivityView(selectedActivity: activity))
            } else {
                NavigationLink("Select", destination: SelectActivityView(selectedActivity: activity))
            }
        }
    }
    
    var body: some View {
        Form {
            HStack {
                Text("When")
                Spacer()
                DatePicker("", selection: $date, displayedComponents: .date)
                    .environment(\.locale, Locale.init(identifier: "de_DE"))
            }

            Section(header: Text("Warmup")) {
                activitySelector(activity: $warmup1)
                activitySelector(activity: $warmup2)
                activitySelector(activity: $warmup3)
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
        .navigationTitle("New Excercise")
    }
    
    private func save() {
        let excercise = Excercise(context: context)
        excercise.when = date
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

        excercise.addToAssignments([
            createAssignment(context: context, order: 1, activity: w1),
            createAssignment(context: context, order: 2, activity: w2),
            createAssignment(context: context, order: 3, activity: w3),
            createAssignment(context: context, order: 1, activity: wout1),
            createAssignment(context: context, order: 2, activity: wout2),
            createAssignment(context: context, order: 3, activity: wout3),
            createAssignment(context: context, order: 4, activity: wout4),
            createAssignment(context: context, order: 5, activity: wout5),
            createAssignment(context: context, order: 6, activity: wout6)
        ])
        
        try! context.save()
        presentationMode.wrappedValue.dismiss()
    }
    
    private func createAssignment(context: NSManagedObjectContext, order: Int16, activity: Activity) -> Assignment {
        let assignment = Assignment(context: context)
        assignment.order = order
        assignment.activity = activity
        return assignment
    }
}
