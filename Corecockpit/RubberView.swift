//
//  RubberView.swift
//  Corecockpit
//
//  Created by Ralf Wirdemann on 09.02.23.
//

import SwiftUI

struct RubberView: View {
    var rubber: String
    var body: some View {
        HStack(spacing: 5) {
            if rubber.contains("/") {
                let rubbers = rubber.components(separatedBy: "/")
                let r1: String = rubbers[0].trimmingCharacters(in: .whitespacesAndNewlines)
                let r2: String = rubbers[1].trimmingCharacters(in: .whitespacesAndNewlines)
                Text(r1)
                    .font(.footnote)
                    .foregroundColor(toColor(rubber: r1))
                Text("/")
                    .font(.footnote)
                Text(r2)
                    .font(.footnote)
                    .foregroundColor(toColor(rubber: r2))
            } else {
                Text(rubber)
                    .font(.footnote)
                    .foregroundColor(toColor(rubber: rubber))
            }
        }
    }
    
    private func toColor(rubber: String) -> Color? {
        if rubber == "yellow" {
            return .yellow
        }
        if rubber == "black" {
            return .black
        }
        if rubber == "black" {
            return .black
        }
        if rubber == "green" {
            return .green
        }
        if rubber == "blue" {
            return .blue
        }
        if rubber == "red" {
            return .red
        }
        return .secondary
    }
}
