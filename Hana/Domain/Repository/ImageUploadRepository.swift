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
