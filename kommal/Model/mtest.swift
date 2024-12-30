//  kommal
//
//  Created by Yara Alsharari on 29/06/1446 AH.
//

//
//  Learner.swift
//  LearnerApp-Mini2
//
//  Created by Reem Quhal on 08/10/2023.
//

import Foundation
import CloudKit

struct Testinfo : Identifiable{
    let id : CKRecord.ID
    let testinfo : String
    
    
    init(record:CKRecord){
        self.id        = record.recordID
        self.testinfo = record["testinfo"] as? String ?? "N/A"
       
    }
    
}
