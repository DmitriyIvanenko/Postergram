//
//  StorageManager.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 01.12.2022.
//

import Foundation
import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    private let bucket = Storage.storage().reference()
    
    public enum IGStorageManagerError: Error {
        case faildToDownload
    }
    
    //MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping (Result<URL, IGStorageManagerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.faildToDownload))
                return
            }
            completion(.success(url))
        })
    }
}
