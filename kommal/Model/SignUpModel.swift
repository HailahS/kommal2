import Foundation
import CloudKit

struct UserInfo : Identifiable{
    let id : CKRecord.ID
    let UserName : String
   
    
    init(record:CKRecord){
        self.id        = record.recordID
        self.UserName = record["UserName"] as? String ?? "N/A"
        
    }
    
}
