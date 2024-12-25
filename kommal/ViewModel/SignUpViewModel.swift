//
//  SignUpViewModel.swift
//  kommal
//

//

import Foundation
import CloudKit

class CloudKitManager: ObservableObject {
    
    private var database: CKDatabase
    
    // نستخدم القاعدة الخاصة للمستخدم
    init() {
        self.database = CKContainer.default().privateCloudDatabase // استخدام القاعدة الخاصة
    }
    
    // دالة لحفظ المستخدم في CloudKit (القاعدة الخاصة)
    func saveUser(userName: String, password: String, phoneNumber: String, completion: @escaping (Result<String, Error>) -> Void) {
        // إنشاء CKRecord جديد من النوع "People"
        let userRecord = CKRecord(recordType: "People")
        
        // إضافة البيانات إلى CKRecord
        userRecord["UserName"] = userName
        userRecord["Password"] = password
        userRecord["PhoneNumber"] = phoneNumber
        
        // حفظ السجل في CloudKit (القاعدة الخاصة)
        database.save(userRecord) { record, error in
            if let error = error {
                // طباعة التفاصيل حول الخطأ
                print("CloudKit Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            // إذا تم الحفظ بنجاح
            if let record = record {
                print("تم حفظ السجل بنجاح: \(record.recordID)")
                completion(.success("تم حفظ البيانات بنجاح: \(record.recordID)"))
            }
        }
    }
}
