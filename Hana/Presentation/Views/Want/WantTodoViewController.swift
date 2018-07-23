//
//  WantTodoViewController.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/07/22.
//

import UIKit

class WantTodoViewController: UIViewController {
    fileprivate let cellIdentifier = R.reuseIdentifier.wantTodoCategoryCell.identifier
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    fileprivate func loadData() {
    
    }
    
    fileprivate func setup() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let widht = view.width / 2 - 2
            layout.itemSize = CGSize(width: widht, height: widht)
        }
        //collectionView.register(R.nib.wa, forCellWithReuseIdentifier: <#T##String#>)
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

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension WantTodoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? WantTodoCategoryCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    
}
