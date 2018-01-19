//
//  UploadStoryViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/12/18.
//

import UIKit

class UploadStoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var uploadImages: [UIImage]?
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }

    func setUpView() {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(R.nib.uploadStoryTextCell(), forCellReuseIdentifier: R.reuseIdentifier.uploadStoryTextCell.identifier)
        tableView.register(R.nib.uploadStoryImageCell(), forCellReuseIdentifier: R.reuseIdentifier.uploadStoryImageCell.identifier)
    }
}

// MARK: - UITableViewDelegate UITableViewDataSource

extension UploadStoryViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.uploadStoryTextCell.identifier, for: indexPath) as? UploadStoryTextCell {
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.uploadStoryImageCell.identifier, for: indexPath) as? UploadStoryImageCell {
                cell.images = uploadImages
                return cell
            }
        default: break
        }
        return UITableViewCell()
    }
    
    
}
