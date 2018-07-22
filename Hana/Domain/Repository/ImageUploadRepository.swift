//
//  ImageUploadRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation
import UIKit

// MARK: - ImageUploadRepository
protocol ImageUploadRepository: Repository {
    typealias CompletionClosure = ((String?, Bool)-> Void)?
    
    func upload(image: UIImage?, closure: CompletionClosure)
}


struct ImageUploadRepositoryImpl: ImageUploadRepository {
    
    private let dao = UploadDao()
    
    func save(by object: Any, closure: Repository.BoolClosure) {
        
    }
    
    func upload(image: UIImage?, closure: ImageUploadRepository.CompletionClosure) {
        dao.upload(image: image, closure: closure)
    }
}
