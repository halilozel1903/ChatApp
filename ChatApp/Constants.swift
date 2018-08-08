//
//  Constants.swift
//  ChatApp
//
//  Created by Halil Özel on 8.08.2018.
//  Copyright © 2018 Halil Özel. All rights reserved.
//

import Foundation
import FirebaseDatabase


struct Constants {
    
    
    static let dbRef = Database.database().reference()
    static let dbChats = dbRef.child("mesajlar")
    
}
