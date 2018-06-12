//
//  EventViewController.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/11.
//

import UIKit

class EventViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedEvent(_ sender: UIButton) {
        SideMenuViewController.show()
    }
    
    @IBAction func tappedCreat(_ sender: UIButton) {
        if let viewController = R.storyboard.createEvent.instantiateInitialViewController() {
            present(viewController, animated: true, completion: nil)
        }
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
