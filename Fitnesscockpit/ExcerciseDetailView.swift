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
            Section(header: Text("Warmup")) {
                List {
                    ForEach(excercise.warmups.array(of: Activity.self)) { w in
                        HStack {
                            Text("\(w.name!)")
                            Spacer()
                            Text("\(w.repititions!)")
                        }
                    }
                }
            }
            Section(header: Text("Workout")) {
                List {
                    ForEach(excercise.workouts.array(of: Activity.self)) { w in
                        VStack(alignment: .leading) {
                            HStack {
                                Text("\(w.name!)")
                                Spacer()
                                Text("\(w.repititions!)")
                            }
                            Text(w.rubber!)
                                .font(.footnote)
                                .foregroundColor(toColor(rubber: w.rubber!))
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
    func array<T: Hashable>(of: T.Type) -> [T] {
        if let set = self as? Set<T> {
            return Array(set)
        }
        return [T]()
    }
}
