//
//  DatabaseProvider.swift
//  NewsReadingApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var username: String?
    @objc dynamic var password: String?
    @objc dynamic var displayname: String = ""
    @objc dynamic var prefList: String = ""
    
    convenience init(username: String, password: String) {
        self.init()
        self.username = username
        self.password = password
    }
    
    func setDisplayName(_ displayname: String) {
        self.displayname = displayname
    }
    
    func appendToPrefsList(_ itemToAdd: String) {
        LocalRealm.instance.appendToUserPrefsList(username!, itemToAdd: itemToAdd)
    }
    
    func removeFromPrefsList(_ itemToRemove: String) {
        LocalRealm.instance.removeFromUserPrefsList(username!, itemToRemove: itemToRemove)
    }
    
    func setPrefsList(_ newList: [String]) {
        LocalRealm.instance.updateUserPrefsList(username!, prefsList: newList.joined(separator: ","))
    }
    
    func getPreferenceList() -> [String] {
        let toReturn: [String] = prefList.split { $0 == "," }.map { String($0) }
        print("User.getPreferenceList(): \(toReturn)")
        return toReturn
    }
}

struct LocalRealm {
    static var instance = LocalRealm()
    private let localRealm = try! Realm()
    
    func addUser(username: String, password: String) -> Bool {
        let predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        let fetchUsers = localRealm.objects(User.self).filter(predicate)
        
        if fetchUsers.count == 0 {
            let newUsr = User(username: username, password: password)
            try! localRealm.write {
                localRealm.add(newUsr)
            }
            return true
        } else {
            return false
        }
        
    }
    
    func findUser(username: String, password: String) -> User? {
        var toReturn: User
        
        let predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        let fetchUsers = localRealm.objects(User.self).filter(predicate)
        print("Done getting user: \(fetchUsers)")
        
        if fetchUsers.count != 0 {
            if let foundUser: User = fetchUsers.first {
                toReturn = foundUser
                return toReturn
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func appendToUserPrefsList(_ username: String, itemToAdd: String) {
        let predicate = NSPredicate(format: "username == %@", username)
        let fetchUsers = localRealm.objects(User.self).filter(predicate)
        if fetchUsers.count != 0 {
            let foundUser = fetchUsers[0]
            
            var currentList: [String] = foundUser.prefList.split { $0 == "," }.map { String($0) }
            currentList.append(itemToAdd)
            
            try! localRealm.write {
                foundUser.prefList = currentList.joined(separator: ",")
            }
            print("Done update user: \(foundUser)")
        }
    }
    
    func removeFromUserPrefsList(_ username: String, itemToRemove: String) {
        let predicate = NSPredicate(format: "username == %@", username)
        let fetchUsers = localRealm.objects(User.self).filter(predicate)
        if fetchUsers.count != 0 {
            let foundUser = fetchUsers[0]
            
            var currentList: [String] = foundUser.prefList.split { $0 == "," }.map { String($0) }
            currentList.removeAll(where: {$0 == itemToRemove})
            
            try! localRealm.write {
                foundUser.prefList = currentList.joined(separator: ",")
            }
            print("Done update user: \(foundUser)")
        }
    }
    
    func updateUserPrefsList(_ username: String, prefsList: String) {
        let predicate = NSPredicate(format: "username == %@", username)
        let fetchUsers = localRealm.objects(User.self).filter(predicate)
        if fetchUsers.count != 0 {
            let foundUser = fetchUsers[0]
            
            try! localRealm.write {
                foundUser.prefList = prefsList
            }
            print("Done update user: \(foundUser)")
        }
    }
    
    func fetchUserInfo(_ username: String) -> User? {
        var toReturn: User
        
        let predicate = NSPredicate(format: "username == %@", username)
        let fetchUsers = localRealm.objects(User.self).filter(predicate)
        print("Done getting user: \(fetchUsers)")
        
        if fetchUsers.count != 0 {
            if let foundUser: User = fetchUsers.first {
                toReturn = foundUser
                return toReturn
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
