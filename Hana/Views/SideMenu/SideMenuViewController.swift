//
//  SideMenuViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/26.
//

import UIKit

fileprivate let sideMenuOffsetX: CGFloat = -220.0

class SideMenuViewController: UIViewController {
    
    static var shared = R.storyboard.sideMenu.sideMenuViewController()

    var normalDataSource = [Int: (image: UIImage, text: String)]()
    
    let sideHeaderIdentifier = R.reuseIdentifier.sideHeaderCell.identifier
    let normalIdentifier = R.reuseIdentifier.sideNormalCell.identifier
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var sideConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        addObserver()
    }

    func setUpView() {
        normalDataSource[0] = (image: UIImage(), text: "Profile")
        let userInfoViewController = R.storyboard.userInfo().instantiateInitialViewController()
        self.addChildViewController(userInfoViewController!)

        let browseViewController = R.storyboard.browse().instantiateInitialViewController()
        normalDataSource[1] = (image: #imageLiteral(resourceName: "search"), text: "Browse")
        self.addChildViewController(browseViewController!)

        let talkHistoryViewController = R.storyboard.chatHistory().instantiateInitialViewController()
        normalDataSource[2] = (image: #imageLiteral(resourceName: "messages"), text: "Messages")
        self.addChildViewController(talkHistoryViewController!)

        let settingViewController = R.storyboard.setting().instantiateInitialViewController()
        normalDataSource[3] = (image: #imageLiteral(resourceName: "setting"), text: "Setting")
        self.addChildViewController(settingViewController!)

        self.sideConstraint.constant = sideMenuOffsetX
        
        let filterViewControllers = childViewControllers.filter({$0 == browseViewController})
        if let firstViewController = filterViewControllers.first {
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
            UIView.animate(withDuration: ModalAnimateDuration, delay: 0, options: .curveEaseInOut, animations: {
                viewController.overlayView.alpha = 0.5
                viewController.view.layoutIfNeeded()
            }) { (isFinish) in
                
            }
        }
    }
    
    func dismiss(completion: @escaping ()-> Void) {

        sideConstraint.constant = sideMenuOffsetX
        UIView.animate(withDuration: ModalAnimateDuration, delay: 0, options: .curveEaseInOut, animations: {
            self.overlayView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (isFinish) in
            if isFinish == true {
                self.view.sendSubview(toBack: self.sideView)
                completion()
            }
        }
    }

}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return normalDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: sideHeaderIdentifier, for: indexPath) as? SideHeaderCell {
                cell.userInfo = DataManager.shared.currentuserInfo
                cell.delegate = self
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
        if indexPath.row == 0 {
            return
        }
        dismiss {
            for subView in self.view.subviews.filter({$0 != self.sideView}) {
                subView.removeFromSuperview()
            }
            
            self.childViewControllers[indexPath.row].didMove(toParentViewController: self)
            self.view.addSubview(self.childViewControllers[indexPath.row].view)
        }
    }
}


// MARK: - SideHeaderCellDelegate
extension SideMenuViewController: SideHeaderCellDelegate {
    
    func didTouchEditProfileButton(with Object: UserInfo?) {
        dismiss {
            if let editUserInfo = R.storyboard.userInfo().instantiateInitialViewController() {
                self.present(editUserInfo, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - PushNotificationDidRecive
extension SideMenuViewController {
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(pushNotificationDidReceive(notification:)), name: .PushNotificationDidRecive, object: nil)
    }
    
    @objc func pushNotificationDidReceive(notification: Notification?) {
//
//        if let message = notification?.object as? Message {
//
//        }
        if let like = notification?.object as? Like  {
            HanaAlertView.show(in: self, object: like) { (like) in
//                if like?.matched {
//                    if let talkRoomViewController = R.storyboard.chatting.chattingViewController() {
//                        self.present(talkRoomViewController, animated: true, completion: nil)
//                    }
//                } else {
//                    if let userInfoViewController = R.storyboard.userInfo.userInfoViewController() {
//                        userInfoViewController.userInfo = userInfo
//                        self.present(userInfoViewController, animated: true, completion: nil)
//                    }
//                }
            }
        }
        
    }
    
}


