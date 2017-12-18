//
//  StoryViewController.swift
//  talk
//
//  Created by ひかりちゃん on 2017/11/13.
//

import UIKit

class StoryViewController: UITableViewController {

    var dataSource: [Posts]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewSetUp()
        refreshControlEvent()
    }

    // MARK: - Set Up
    func viewSetUp() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshControlEvent), for: .valueChanged)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(R.nib.postsTableViewCell(), forCellReuseIdentifier: R.reuseIdentifier.postsTableViewCell.identifier)
    }
    
    // MARK: - Action
    @objc func refreshControlEvent() {
        refreshControl?.beginRefreshing()
        PostsApi.findAllPosts { (response) in
            if response.status == .success {
                self.dataSource = response.data
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }
    
    @IBAction func tapBarUploadEvent(_ sender: UIButton) {
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return dataSource?.count ?? 0
    }

     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.postsTableViewCell.identifier) as? PostsTableViewCell {
            cell.displayData = dataSource?[indexPath.row]
            return cell
        }

        return UITableViewCell()
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
