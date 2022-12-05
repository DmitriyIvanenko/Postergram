//
//  AuthManager.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 01.12.2022.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    public func registerNewUser(username: String, email: String, password: String, complition: @escaping (Bool) -> Void) {
        /*
         - Check if Username is available
         - Check if Email is available
         */
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                // - Create account
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        //Firebase Auth can not create account
                        complition(false)
                        return
                    }
                }
                // - Insert into Database
                DatabaseManager.shared.insertNewUser(with: email, username: username) { inserted in
                    if inserted {
                        //Success insert to database
                        complition(true)
                        return
                    }
                    else {
                        //Faild insert to database
                        complition(false)
                        return
                    }
                }
            }
            else {
                //eather Usernam or Email does not exist
                complition(false)
            }
        }
    }
    
    
    //MARK: - Log In
    
    public func loginUser(username: String?, email: String?, password: String, complition: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    complition(false)
                    return
                }
                complition(true)
            }
        }
        else if let username = username {
            print(username)
        }
    }
    
    //MARK: - Log Out

    public func logOut(comletion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            comletion(true)
            return
        }
        catch {
            comletion(false)
            return
        }
    }

}
