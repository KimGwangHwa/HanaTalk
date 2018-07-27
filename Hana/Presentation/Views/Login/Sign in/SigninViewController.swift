//
//  SigninViewController.swift
//  Hana
//
//  Created by ccsuser02 on 2018/07/27.
//

import UIKit

class SigninViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var signinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    func setup() {
        scrollView.backgroundColor = UIColor.hex("f2f2f0")
        signinButton.setBackgroundImage(UIImage.colorImage(color: UIColor.lightGray, size: CGSize(width: 100, height: 100)), for: .normal)
    }
    
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
