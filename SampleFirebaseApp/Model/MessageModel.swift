//
//  MessageModel.swift
//  SampleFirebaseApp
//
//  Created by matthew savidge on 12/22/21.
//

import Foundation

struct MessageModel{
    let sender: String
    let body: String
    
    struct Fstore{
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
