//
//  SignUpModel.swift
//  kommal
//

import Foundation
import CloudKit

struct User: Identifiable {
    let id: CKRecord.ID
    let userName: String
    let password: String
    let phoneNumber: String
    init(record: CKRecord) {
        self.id = record.recordID
        self.userName = record["UserName"] as? String ?? "N/A"
        self.password = record["Password"] as? String ?? "N/A"
        self.phoneNumber = record["PhoneNumber"] as? String ?? "N/A"
    }
}
