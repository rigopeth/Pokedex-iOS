//
//  SearchMode.swift
//  Pokedex
//
//  Created by Rigoberto Dominguez Garcia on 29/03/26.
//

import Foundation

enum SearchMode: String, CaseIterable, Identifiable {
    case nameOrNumber = "Name or Number"
    case type = "Type"
    var id: String {
        rawValue
    }
}
