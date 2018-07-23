//
//  BrowseViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2018/02/28.
//

import UIKit

private let reuseIdentifier = R.reuseIdentifier.browseCell.identifier

class BrowseViewController: UIViewController {

    @IBOutlet weak var swipeableView: SwipeableView!
    
    var dataSource: [UserInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        loadRemoteData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // That you want to of today
        if isShowTodayWantTodo() {
            if let viewController = R.storyboard.wantTodo.instantiateInitialViewController() {
                present(viewController, animated: true, completion: nil)
            }
        }
    }
    
    fileprivate func isShowTodayWantTodo() -> Bool {
        if let endDate = DataManager.shared.currentuserInfo!.todayWantEnd {
            if Date() > endDate {
                return true
            } else {
                return false
            }
        }
        return true
    }
    

    fileprivate func setupLayout() {
        setNavigationBarBackIndicatorImage(R.image.icon_back()!)
        swipeableView.leftSwipingImage = R.image.icon_large_dislike()
        swipeableView.rightSwipingImage = R.image.icon_large_like()

        swipeableView.delegate = self
        swipeableView.dataSource = self

    }

    func loadRemoteData() {
        UserInfoDao.findAll  { (objects, isSuccess) in
            self.dataSource = objects
            self.swipeableView.reloadData()
        }
    }
    
    @IBAction func sideMenuButtonEvent(_ sender: UIButton) {
        SideMenuViewController.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - SwipeableViewDelegate, SwipeableViewDataSource
extension BrowseViewController: SwipeableViewDelegate, SwipeableViewDataSource {
    
    func numberOfRow() -> Int {
        return dataSource?.count ?? 0
    }
    
    func swipeableView(_ swipeableView: SwipeableView, displayViewForRowAt index: Int) -> UIView {
        
        if let cardView = R.nib.browseCardView.firstView(owner: nil) {
            cardView.model = dataSource?[index]
            return cardView
        }
        return UIView()
    }
    
    func swipeableView(_ swipeableView: SwipeableView, didSelectRowAt index: Int) {
        if let userInfoViewController = R.storyboard.userInfo.userInfoViewController() {
            userInfoViewController.userInfo = dataSource?[index]
            navigationController?.pushViewController(userInfoViewController, animated: true)
        }
    }

}



