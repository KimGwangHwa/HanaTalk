//
//  SettingViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/03/06.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

    private func setup() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "icon_settings"))
        setNavigationBarBackIndicatorImage(#imageLiteral(resourceName: "icon_back"))
        navigationBarBackgroundImageIsHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func sideMenuEvent(_ sender: UIButton) {
        SideMenuViewController.show()
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
