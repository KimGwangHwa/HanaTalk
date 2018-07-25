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
    let usercase = BrowseUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLayout()
        loadRemoteData()
    }
    
    fileprivate func setupLayout() {
        setNavigationBarBackIndicatorImage(R.image.icon_back()!)
        //navigationController?.navigationBar.barTintColor = MainColor
        swipeableView.leftSwipingImage = R.image.icon_large_dislike()
        swipeableView.rightSwipingImage = R.image.icon_large_like()
        swipeableView.backgroundColor = BackgroundColor
        
        swipeableView.delegate = self
        swipeableView.dataSource = self

    }

    func loadRemoteData() {
        usercase.read { (models, isSuccess) in
            self.swipeableView.reloadData()
        }
    }
    
    @IBAction func sideMenuButtonEvent(_ sender: UIButton) {
        SideMenuViewController.show()
    }
    
    @IBAction func tappedFilter(_ sender: UIButton) {
    
    }
    
    @IBAction func tappedCountDown(_ sender: UIButton) {
        if let viewController = R.storyboard.wantTodo.instantiateInitialViewController() {
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - SwipeableViewDelegate, SwipeableViewDataSource
extension BrowseViewController: SwipeableViewDelegate, SwipeableViewDataSource {
    
    func numberOfRow() -> Int {
        return usercase.data?.count ?? 0
    }
    
    func swipeableView(_ swipeableView: SwipeableView, displayViewForRowAt index: Int) -> UIView {
        
        if let cardView = R.nib.browseCardView.firstView(owner: nil) {
            cardView.model = usercase.data?[index]
            return cardView
        }
        return UIView()
    }
    
    func swipeableView(_ swipeableView: SwipeableView, didSelectRowAt index: Int) {
        if let userInfoViewController = R.storyboard.userInfo.userInfoViewController() {
            //userInfoViewController.userInfo = dataSource?[index]
            navigationController?.pushViewController(userInfoViewController, animated: true)
        }
    }
    
    func swipeableView(_ swipeableView: SwipeableView, didSwipedAt direction: DraggableDirection) {
        if direction == .left {
            
        } else if direction == .right {
            
        }
    }

}



