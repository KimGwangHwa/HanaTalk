//
//  CoreDataManager.swift
//  talk
//
//  Created by ひかりちゃん on 2017/08/09.
//
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class CoreDataManager: NSObject {
    
    private let appdelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func create() {
        let tweet = NSEntityDescription.entity(forEntityName: "LoginHistory", in: context)
        let history = LoginHistory(entity: tweet!, insertInto: context)
        history.id = "djdkjdjk"
        do {
            try context.save()
        } catch {
        }
    }
    
    func read() {
        
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "LoginHistory")
        var result = [AnyObject]()
        // 読み込み実行
        do {
            result = try context.fetch(fetchReq)
        }catch{
            
        }
        // Shopインスタンスを生成
        let shop = result[0] as! LoginHistory
        // データにアクセス
        print(shop.id)
    }
    
    func update() {
        
    }
    
    func delete() {
        
    }
}
