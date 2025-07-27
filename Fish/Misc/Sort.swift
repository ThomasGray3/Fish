//
//  Sort.swift
//  Fish
//
//  Created by Thomas Gray on 27/07/2025.
//

import Foundation

enum SortField: String, CaseIterable, Identifiable {
    case date
    case species
    case length
    case weight
    
    var id: Self { self }
    
    var label: String {
        switch self {
        case .date: "Date"
        case .species: "Species"
        case .length: "Length"
        case .weight: "Weight"
        }
    }
    
    func sortDescriptor(order: SortOrder) -> SortDescriptor<Fish> {
        switch self {
        case .date: SortDescriptor(\Fish.date, order: order)
        case .species: SortDescriptor(\Fish.species, order: order)
        case .length: SortDescriptor(\Fish.length, order: order)
        case .weight: SortDescriptor(\Fish.weight, order: order)
        }
    }
}
