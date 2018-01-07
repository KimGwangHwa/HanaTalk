//
//  PeekViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/01/03.
//

import UIKit

class PeekViewController: BaseViewController {
    
    public var image: UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = image
        // Do any additional setup after loading the view.
    }
    
//    override var previewActionItems: [UIPreviewActionItem] {
//        let action =  UIPreviewAction(title: "test", style: .default) { (action, viewController) in
//            
//        }
//        return [action]
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
