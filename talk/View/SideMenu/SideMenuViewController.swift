//
//  SideMenuViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/26.
//

import UIKit


class SideMenuViewController: UIViewController {
    
    static var shared = R.storyboard.sideMenu.sideMenuViewController()

    private static let sideMenuWidth: CGFloat = 220.0
    private static let animateDuration: TimeInterval = 0.35
    
    var normalDataSource = [Int: (image: UIImage, text: String)]()
//    var normalDataSource: [Int: (image: UIImage, text: String)] = [SideMenuCategory.browse.rawValue: (#imageLiteral(resourceName: "search"), "Browse"), SideMenuCategory.event.rawValue: (#imageLiteral(resourceName: "event"), "Event"), SideMenuCategory.matches.rawValue: (#imageLiteral(resourceName: "hear"), "My matches"), SideMenuCategory.messages.rawValue: (#imageLiteral(resourceName: "messages"), "Messages"), SideMenuCategory.favorites.rawValue: (#imageLiteral(resourceName: "favorite"), "Favorites"), SideMenuCategory.settings.rawValue: (#imageLiteral(resourceName: "setting"), "Settings"), ]

    func addChildViewController(_ viewController: UIViewController?, iconImage: UIImage, description: String) {
        if let guardViewController = viewController {
            self.addChildViewController(guardViewController)
            if let index = self.childViewControllers.index(of: guardViewController) {
                normalDataSource[index] = (image: iconImage, text: description)
            }
        }
    }
    
    let sideHeaderIdentifier = R.reuseIdentifier.sideHeaderCell.identifier
    let normalIdentifier = R.reuseIdentifier.sideNormalCell.identifier
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var sideConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }

    func setUpView() {
        self.sideConstraint.constant = -SideMenuViewController.sideMenuWidth
        if let firstViewController = childViewControllers.first {
            firstViewController.didMove(toParentViewController: self)
            view.addSubview(firstViewController.view)
        }
        
        
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(R.nib.sideHeaderCell(), forCellReuseIdentifier: sideHeaderIdentifier)
        tableView.register(R.nib.sideNormalCell(), forCellReuseIdentifier: normalIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutEvent(_ sender: UIButton) {
        
    }
    
    @IBAction func viewTapEvent(_ sender: UITapGestureRecognizer) {
        dismiss {
            
        }
    }
    
    class func show() {
        if let viewController = shared {
            viewController.view.bringSubview(toFront: viewController.sideView)
            viewController.sideView.setNeedsLayout()
            viewController.sideConstraint.constant = 0
            UIView.animate(withDuration: animateDuration, delay: 0, options: .curveEaseInOut, animations: {
                viewController.overlayView.alpha = 0.5
                viewController.view.layoutIfNeeded()
            }) { (isFinish) in
                
            }
        }
    }
    
    func dismiss(completion: @escaping ()-> Void) {

        sideConstraint.constant = -SideMenuViewController.sideMenuWidth
        UIView.animate(withDuration: SideMenuViewController.animateDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.overlayView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (isFinish) in
            if isFinish == true {
                self.view.sendSubview(toBack: self.sideView)
                completion()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return normalDataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: sideHeaderIdentifier, for: indexPath) as? SideHeaderCell {
                return cell
            }

        } else {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: normalIdentifier, for: indexPath) as? SideNormalCell {
                
                cell.iconImageView.image = normalDataSource[indexPath.row]?.image
                cell.descriptionLabel.text = normalDataSource[indexPath.row]?.text
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        dismiss {
            for subView in self.view.subviews.filter({$0 != self.sideView}) {
                subView.removeFromSuperview()
            }
            
            self.childViewControllers[indexPath.row].didMove(toParentViewController: self)
            self.view.addSubview(self.childViewControllers[indexPath.row].view)
        }
//
    }
}





