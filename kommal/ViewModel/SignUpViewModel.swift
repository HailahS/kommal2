import Foundation
import CloudKit

class ViewModel: ObservableObject {
    @Published var users: [UserInfo] = []  // تخزين قائمة المستخدمين
    
    // 1. دالة لاستعلام البيانات (fetchLearners)
    func fetchLearners() {
        let predicate = NSPredicate(value: true)
        
        // استعلام لبيانات المستخدمين من CloudKit
        let query = CKQuery(recordType: "UserInfo", predicate: predicate)
        
        let operation = CKQueryOperation(query: query)
        operation.recordMatchedBlock = { recordId, result in
            DispatchQueue.main.async {
                switch result {
                case .success(let record):
                    let user = UserInfo(record: record)  // تحويل السجل إلى كائن UserInfo
                    self.users.append(user)  // إضافة المستخدم إلى قائمة المستخدمين
                case .failure(let error):
                    print("Error fetching user: \(error.localizedDescription)")
                }
            }
        }
        
        // إضافة العملية إلى قاعدة البيانات
        CKContainer(identifier: "iCloud.hailah.kommal").publicCloudDatabase.add(operation)
    }
    
    // 2. دالة لإضافة مستخدم جديد (addUser)
    func addUser(userName: String, completion: @escaping (Result<Void, Error>) -> Void) {
        // تحقق من توفر اسم المستخدم
        guard !userName.isEmpty else {
            completion(.failure(NSError(domain: "com.app.error", code: 400, userInfo: [NSLocalizedDescriptionKey: "Username cannot be empty"])))
            return
        }
        
        // إنشاء سجل جديد من نوع "UserInfo"
        let record = CKRecord(recordType: "UserInfo")
        record["UserName"] = userName  // تخزين اسم المستخدم في السجل
        
        // حفظ السجل في CloudKit
        CKContainer(identifier: "iCloud.hailah.kommal").publicCloudDatabase.save(record) { _, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error saving user: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("User \(userName) added successfully!")
                    completion(.success(()))
                }
            }
        }
    }
}

