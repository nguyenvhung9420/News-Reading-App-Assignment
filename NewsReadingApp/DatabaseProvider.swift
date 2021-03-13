//
//  DatabaseProvider.swift
//  NewsReadingApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import Foundation
import RealmSwift


class User: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var owner: String?
    @objc dynamic var status: String = ""
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}

struct LocalRealm {
    
    static var instance = LocalRealm()
    
    private let localRealm = try! Realm()
    
    func addUser() {
        // Add some tasks
        let task = User(name: "Do laundry")
        try! localRealm.write {
            localRealm.add(task)
        }
    }
    
    func findUser() -> User {
        
        var toReturn: User =  User()
        
        let predicate = NSPredicate(format: "name == %@", "Ali")
        let tasksThatBeginWithA = localRealm.objects(User.self).filter(predicate)
        print("A list of all tasks that begin with A: \(tasksThatBeginWithA)")
        
        if tasksThatBeginWithA.count != 0 {
            if let foundUser: User =  tasksThatBeginWithA.first {
                toReturn =  foundUser
            }
        }
        
       return toReturn
    }
    
}
