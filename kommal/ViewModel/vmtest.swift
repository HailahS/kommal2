//
//  vmtest.swift
//  kommal
//
//  Created by Yara Alsharari on 29/06/1446 AH.
//

//
//  LearnerViewModel.swift
//  LearnerApp-Mini2
//
//  Created by Reem Quhal on 08/10/2023.
//

import Foundation

import CloudKit

class vmtest: ObservableObject{
    @Published var testt : [Testinfo] = []
    private var container: CKContainer
    
    init(){
        self.container = CKContainer(identifier: "iCloud.hailah.kommal")
    }
    
    //1
    func fetchLearners(){
      
        let predicate = NSPredicate(value: true)
        //2
        //let predicate2 = NSPredicate(format: "firstName == %@", "Sara")
        
        //Record Type depends on what you have named it
        let query = CKQuery(recordType:"test", predicate: predicate)
        
        
        let operation = CKQueryOperation(query: query)
        operation.recordMatchedBlock = { recordId, result in
            print("hii")
            print(recordId.recordName," uu ")
            DispatchQueue.main.async {
                switch result{
                case .success(let record):
                    let testt1 = Testinfo(record: record)
                    self.testt.append(testt1)
                    
                case .failure(let error):
                    print("\(error.localizedDescription)")
                   
                }
            }
        }
        CKContainer(identifier: "iCloud.hailah.kommal").publicCloudDatabase.add(operation)
//
//        CKContainer(identifier: "iCloud.ghadaacademy.kommal").publicCloudDatabase.add(operation)
        
        
        
    }
    
   
    
    
}
