//
//  LoginView.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//


import Foundation
import SwiftUI
import KeyboardObserving
import Combine

struct LoginScreen:  View {
    
    @EnvironmentObject var authProvider: AuthenticationProvider
    
    @State var password: String = ""
    @State var email: String = ""
    @State var counter: Int = 0
    
    @State private var showSignUpError = false
    @State private var showSignInError = false
    @State private var showResetPsswrdError = false
    @State private var showResetPsswrdSent = false
    
    @State private var currentError: Error?
    @State private var currentAnnounce: String? = ""
    
    @State private var selection = 0 // 0 for register, 1 for login
    
    
    var body: some View {
        
       
        VStack {
            
            Picker(selection: $selection, label: Text("What you wanna do?")) {
                Text("Register").tag(0)
                Text("Log In").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            
            if selection == 0 {
                Text("Register").bold().font(.title)
            } else {
                Text("Log In").bold().font(.title)
            }
            
            if (self.currentError != nil) {
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Error").foregroundColor(Color.white).bold()
                        Spacer()
                        Button(action: {
                            self.currentError = nil
                        }){
                            Image(systemName: "xmark.circle").foregroundColor(Color.white)
                        }
                        
                    }
                    Text(String(self.currentError!.localizedDescription))
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.white)
                }.padding().background(Color.red).cornerRadius(12)
                
            }
            
            if (self.currentAnnounce != "") {
                
                VStack(alignment: .leading) {
                    HStack{
                        Text("Info").foregroundColor(Color.white).bold()
                        Spacer()
                        Button(action: {
                            self.currentAnnounce = ""
                        }){
                            Image(systemName: "xmark.circle").foregroundColor(Color.white)
                        }
                        
                    }
                    Text(String(self.currentAnnounce!))
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.white)
                }.padding().background(Color.blue).cornerRadius(12)
                
                
                
            }
            
            
            TextField("Email", text: self.$email)
                .padding()
                .background(Color.gray.opacity(0.08))
                .cornerRadius(12.0).keyboardType(.emailAddress).autocapitalization(.none)
            
            SecureField("Password", text: self.$password) {
                // submit the password
            }.padding()
            .background(Color.gray.opacity(0.08))
            .cornerRadius(12.0).keyboardType(.emailAddress).autocapitalization(.none)
            
            Button(action: submit) {
                HStack(alignment: .center) {
                    Spacer()
                    Text(self.selection == 0 ? "Register" : "Login").foregroundColor(Color.white).bold()
                    Spacer()
                }
            }.padding().background(Color.green).cornerRadius(12.0)
            
            if self.selection == 1 {
                Button(action: sendPasswordReset) {
                    Text("Forgot Password?").font(.system(size: 15))
                }.padding()
            }
            }
        .animation(.default)
        .padding().keyboardObserving()
    }
    
    func submit() {
        print($email)
        print($password)
        
        authProvider.loggedIn = true
        
        if selection == 0 {
//            Auth.auth().createUser(withEmail: self.email, password: self.password) {
//                authResult, error in
//                self.currentAnnounce = "Welcome back, \(self.email). Please wait."
//                if let e = error {
//                    print(e.localizedDescription)
//                    self.currentError = e
//                    self.currentAnnounce = ""
//                } else {
//                    self.fetcher.makeLoggedIn(email: self.email)
//                }
//            }
            
        } else {
//            Auth.auth().signIn(withEmail: email, password: password){
//                authResult , error in
//                self.currentAnnounce = "Welcome back, \(self.email). Please wait."
//                if let e = error {
//                    print(e.localizedDescription)
//                    self.currentError = e
//                    self.currentAnnounce = ""
//                } else {
//                    self.fetcher.makeLoggedIn(email: self.email)
//
//                }
//
//
//            }
        }
    }
    
    func sendPasswordReset() {
        print($email)
        print($password)
        
//        Auth.auth().sendPasswordReset(withEmail: email){ error in
//            if let e = error {
//                print(e.localizedDescription)
//                self.currentError = e
//            }
//            self.currentAnnounce = "An email containing instruction to recover your password will be sent to \(self.email) if your email is already registered."
//        }
        
    }
    
}

