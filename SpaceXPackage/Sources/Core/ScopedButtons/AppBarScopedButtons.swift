//
//  File.swift
//  
//
//  Created by Hugo on 13/09/2022.
//

import Foundation

public enum AppBarScopedButtons: String, Identifiable, CaseIterable {
    case asc = "ASC"
    case desc = "DESC"
    
    public var id: AppBarScopedButtons { self }
}
