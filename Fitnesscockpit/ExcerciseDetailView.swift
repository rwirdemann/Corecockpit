//
//  ExcerciseDetailView.swift
//  Fitnesscockpit
//
//  Created by Ralf Wirdemann on 19.12.22.
//

import SwiftUI

struct ExcerciseDetailView: View {
    @Environment(\.managedObjectContext) private var context
    @Environment(\.presentationMode) var presentationMode
    let excercise: Excercise
    
    var body: some View {
        Form {
            HStack {
                Text(excercise.when!, formatter: itemFormatter)
                Spacer()
                Button("Complete", action: complete)
                    .disabled(excercise.complete)
            }
            Section(header: Text("Warmup")) {
                List {
                    ForEach(excercise.assignments.array(filter: Constants.WARMUP)) { a in
                        HStack {
                            Text("\(a.activity!.name!)")
                            Spacer()
                            Text("\(a.activity!.repititions!)")
                        }
                    }
                }
            }
            Section(header: Text("Workout")) {
                List {
                    ForEach(excercise.assignments.array(filter: Constants.WORKOUT)) { a in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(a.activity!.name!)")
                                Spacer()
                                Text("\(a.activity!.repititions!)")
                            }
                            Text(a.activity!.rubber!)
                                .font(.footnote)
                                .foregroundColor(toColor(rubber: a.activity!.rubber!))
                        }
                    }
                }
            }
        }
    }
    
    private func complete() {
        for a in excercise.assignments.array() {
            a.activity?.executions += 1
        }
        excercise.complete = true
        try! context.save()
        presentationMode.wrappedValue.dismiss()
    }
    
    private func toColor(rubber: String) -> Color? {
        if rubber == "yellow" {
            return .yellow
        }
        return .primary
    }
}

extension Optional where Wrapped == NSSet {
    func array(filter: String = "") -> [Assignment] {
        if let set = self as? Set<Assignment> {
            let a = Array(set)
            if filter != "" {
                let filtered =  a.filter { w in
                    return w.activity!.phase == filter
                }
                return filtered.sorted(by: { $0.order <= $1.order })
            }
            return a.sorted(by: { $0.order <= $1.order })
        }
        return [Assignment]()
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "de")
    formatter.dateFormat = "EEEE, d. MMM y"
    formatter.locale = Locale(identifier: "de")
    return formatter
}()
