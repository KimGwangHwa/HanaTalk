//
//  ImageUploadRepository.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/17.
//

import Foundation
import UIKit

// MARK: - ImageUploadRepository
protocol ImageUploadRepository {

    func upload(image: UIImage?, closure: ((String?, Bool) -> Void)?)
}


struct ImageUploadRepositoryImpl: ImageUploadRepository {
    private let dao = UploadDao()

    func upload(image: UIImage?, closure: ((String?, Bool) -> Void)?) {
        dao.upload(image: image, closure: closure)
    }
}
