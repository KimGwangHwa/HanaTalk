//
//  SideMenuViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/26.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    private static let sideMenuViewController = R.storyboard.sideMenu.sideMenuViewController()
    private static let sideMenuWidth: CGFloat = 220.0
    private static let animateDuration: TimeInterval = 0.35
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var overlayView: UIView!
    
    @IBOutlet weak var sideConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }

    func setUpView() {
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutEvent(_ sender: UIButton) {
        
    }
    
    @IBAction func viewTapEvent(_ sender: UITapGestureRecognizer) {
        SideMenuViewController.dismiss()
    }
    
    class func show() {
        if let viewController = sideMenuViewController {
            UIApplication.shared.keyWindow?.addSubview(viewController.view)
            viewController.sideConstraint.constant = 0
            UIView.animate(withDuration: animateDuration, delay: 0, options: .curveEaseInOut, animations: {
                viewController.overlayView.alpha = 0.5
                viewController.view.layoutIfNeeded()
            }) { (isFinish) in
                
            }
        }
    }
    
    class func dismiss() {
        if let viewController = sideMenuViewController {
            viewController.sideConstraint.constant = -sideMenuWidth
            UIView.animate(withDuration: animateDuration, delay: 0, options: .curveEaseInOut, animations: {
                viewController.overlayView.alpha = 0
                viewController.view.layoutIfNeeded()
            }) { (isFinish) in
                if isFinish == true {
                    viewController.view.removeFromSuperview()
                }
            }
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

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return cell
    }
}





