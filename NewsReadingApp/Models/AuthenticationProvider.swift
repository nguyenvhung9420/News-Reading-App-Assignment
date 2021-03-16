//
//  AuthenticationProvider.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import Foundation
import Combine


public class AuthenticationProvider: ObservableObject {
    
    @Published var loggedUser: User?
    
    func retrieveLoggedInUser() {
        if let loggedInUsername: String = UserDefaults.standard.string(forKey: "logged_in_username") {
            if let fetchedUser = LocalRealm.instance.fetchUserInfo(loggedInUsername) {
                loggedUser = fetchedUser
                print("Done retrieving the logged in user: \(self.loggedUser?.username)")
            }
        }
    }
    
    func login(username: String, password: String) -> Bool {
        guard let user: User =  LocalRealm.instance.findUser(username: username, password: password) else {
            print("Incorrect username/password or user does not exist.")
            return false
        }
        print("Logging in successful with \(user.username!)")
        self.loggedUser = user
        UserDefaults.standard.set(self.loggedUser?.username, forKey: "logged_in_username")
        return true
    }
    
    func logout() -> Bool {
        UserDefaults.standard.removeObject(forKey: "logged_in_username")
        print(UserDefaults.standard.string(forKey: "logged_in_username")) 
        return true
    }
    
}
