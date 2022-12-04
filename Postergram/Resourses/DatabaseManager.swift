//
//  DataBaseManager.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 01.12.2022.
//

import FirebaseDatabase

public class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    //MARK: - Public
    
    ///Check if Username and Email is available
    ///- Parameters
    ///- Username: String representing username
    ///- Email: String representing email
 
    public func canCreateNewUser(with email: String, username: String, complition: (Bool) -> Void ) {
        complition(true)
    }
    
    ///Insert new User Data to database
    ///- Parameters
    ///- Username: String representing username
    ///- Email: String representing email
    ///- Complition: Async  callback for result if database entry succeded
    public func insertNewUser(with email: String, username: String, coplition: @escaping (Bool) -> Void ) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if  error == nil {
                //succeded
                coplition(true)
                return
            }
            else {
                //faild
                coplition(false)
                return
            }
        }
    }

}
