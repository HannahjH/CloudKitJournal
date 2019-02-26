//
//  Entry.swift
//  CloudKitJournal
//
//  Created by Hannah Hoff on 2/25/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    
    static let recordKey = "Entry"
    static let titleKey = "Title"
    static let bodyKey = "Body"
}

class Entry {
    
    var title: String
    var body: String
    var ckRecordID: CKRecord.ID
    
    init(title: String, body: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.ckRecordID = ckRecordID
    }
    
    convenience init?(ckRecord: CKRecord) {
        
        guard let title = ckRecord[Constants.titleKey] as? String,
            let body = ckRecord[Constants.bodyKey] as? String else {return nil}
        
        self.init(title: title, body: body, ckRecordID: ckRecord.recordID)
        
    }
}

extension Entry: Equatable {
    
    static func ==(lhs: Entry, rhs: Entry) -> Bool{
        return lhs.title == rhs.title && lhs.body == rhs.body
    }
}


extension CKRecord {
    
    convenience init(entry: Entry) {
        self.init(recordType: Constants.recordKey, recordID: entry.ckRecordID)
        
        self.setValue(entry.title, forKey: Constants.titleKey)
        self.setValue(entry.body, forKey: Constants.bodyKey)
    }
}
