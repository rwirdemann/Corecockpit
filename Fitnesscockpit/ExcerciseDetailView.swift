//
//  ExcerciseDetailView.swift
//  Fitnesscockpit
//
//  Created by Ralf Wirdemann on 19.12.22.
//

import SwiftUI

struct ExcerciseDetailView: View {
    let excercise: Excercise
    
    var body: some View {
        Form {
            Text(excercise.when!, formatter: itemFormatter)
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
    
    private func toColor(rubber: String) -> Color? {
        if rubber == "yellow" {
            return .yellow
        }
        return .primary
    }
}

extension Optional where Wrapped == NSSet {
    func array(filter: String) -> [Assignment] {
        if let set = self as? Set<Assignment> {
            let a = Array(set)
            let filtered =  a.filter { w in
                return w.activity!.phase == filter
            }
            let sorted = filtered.sorted(by: { $0.order <= $1.order })
            return sorted
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
