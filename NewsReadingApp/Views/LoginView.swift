//
//  LoginView.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import Combine
import Foundation
import KeyboardObserving
import SwiftUI

struct LoginScreen: View {
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
    
    @State private var showingLoginFailedAlert: Bool = false
    @State private var showingSignupFailedAlert: Bool = false
    
    var onPressLogIn: () -> Void
    
    init(onPressLogIn: @escaping () -> Void = {}) {
        self.onPressLogIn = onPressLogIn
    }
    
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
            
            if self.currentError != nil {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Error").foregroundColor(Color.white).bold()
                        Spacer()
                        Button(action: {
                            self.currentError = nil
                        }) {
                            Image(systemName: "xmark.circle").foregroundColor(Color.white)
                        }
                    }
                    Text(String(self.currentError!.localizedDescription))
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.white)
                }.padding().background(Color.red).cornerRadius(12)
            }
            
            if self.currentAnnounce != "" {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Info").foregroundColor(Color.white).bold()
                        Spacer()
                        Button(action: {
                            self.currentAnnounce = ""
                        }) {
                            Image(systemName: "xmark.circle").foregroundColor(Color.white)
                        }
                    }
                    Text(String(self.currentAnnounce!))
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.white)
                }.padding().background(Color.blue).cornerRadius(12)
            }
            
            TextField("Username", text: self.$email)
                .padding()
                .background(Color.gray.opacity(0.08))
                .cornerRadius(12.0).keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            
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
        }
        .animation(.default)
        .padding()
        .alert(isPresented: $showingLoginFailedAlert) {
            Alert(title: Text("Error"), message: Text("Wrong username/password or the user does not exist."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showingSignupFailedAlert) {
            Alert(title: Text("Error"), message: Text("This username already exist."), dismissButton: .default(Text("OK")))
        }
        .keyboardObserving()
    }
    
    func submit() {
        if selection == 0 {
            let signupSucess: Bool = LocalRealm.instance.addUser(username: self.email, password: self.password)
            if signupSucess {
                self.showingLoginFailedAlert = !authProvider.login(username: self.email, password: self.password)
                self.onPressLogIn()
            } else {
                self.showingSignupFailedAlert = true
            }
        } else {
            print("This is logging in")
            self.showingLoginFailedAlert = !authProvider.login(username: self.email, password: self.password)
        }
    }
}
