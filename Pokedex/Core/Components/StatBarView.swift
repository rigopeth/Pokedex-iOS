//
//  StatBarView.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 29/03/26.
//

import SwiftUI

struct StatBarView: View {
    
    let name: String
    let value: Int
    
    @State private var animatedValue: CGFloat = 0.0
    
    private var normalizedValue: CGFloat {
        CGFloat(value) / 200.0
    }
    var body: some View {
        HStack {
            Text(formattedName)
                .font(.caption)
                .frame(width: 100, alignment: .leading)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                    Capsule()
                        .fill(color)
                        .frame(width: geo.size.width * animatedValue)
                }
            }
            .frame(height: 10)
            Text("\(value)")
                .font(.caption2)
                .frame(width: 30)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.8)) {
                animatedValue = normalizedValue
            }
        }
    }
    
    private var formattedName: String {
        name
            .replacingOccurrences(of: "-", with: " ")
            .capitalized
    }
    
    private var color: Color {
        switch value {
        case 0..<50: return .red
        case 50..<90: return .orange
        case 90..<120: return .yellow
        default: return .green
        }
    }
    
}

#Preview {
    StatBarView(name: "attack", value: 85)
}
