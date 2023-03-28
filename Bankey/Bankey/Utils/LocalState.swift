//
//  LocalState.swift
//  Bankey
//
//  Created by Josh on 3/28/23.
//

import Foundation
public class LocalState {
    
    private enum Keys: String {
        case hasOnboarded
    }
    
    public static var hasOnboarded: Bool {
        get {                                   // rawvalue how you get the string interpretation as enum
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
        }
        // can pass in a boolean the new val, and write it to disk
        set(newValue) {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarded.rawValue)
//            UserDefaults.standard.synchronize()
        }
    }
    
}
