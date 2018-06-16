//
//  FindLocationViewController.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/16.
//

import UIKit
import CoreLocation

class FindLocationViewController: UIViewController {

    let locationCellIdentifier = R.reuseIdentifier.locationCell.identifier
    var searchController = UISearchController(searchResultsController: nil)
    var locationManager = CLLocationManager()
    
    var searchDataSource = [CLPlacemark]()
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        locationManager.delegate = self
        locationManager.requestLocation()
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 100
        tableview.register(R.nib.locationCell(), forCellReuseIdentifier: locationCellIdentifier)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "placeholder"
        searchController.hidesNavigationBarDuringPresentation = false
        tableview.tableFooterView = UIView()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func placeName(location: CLLocation?, closure: @escaping (CLPlacemark?) -> Void) {
        // Use the last reported location.
        if let lastLocation = location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    let firstLocation = placemarks?[0]
                                                    closure(firstLocation)
                                                }
                                                else {
                                                    // An error occurred during geocoding.
                                                    closure(nil)
                                                }
            })
        }
    }
}

// MARK: - Navigation

extension FindLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchDataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableview.dequeueReusableCell(withIdentifier: locationCellIdentifier, for: indexPath) as? LocationCell {
            let mark = searchDataSource[indexPath.row]
            cell.textLabel?.text = mark.name
            //+ (mark.subLocality ?? "") + (mark.subThoroughfare ?? "")
            let detailLocationName = (mark.subLocality ?? "") + (mark.subThoroughfare ?? "")
            cell.detailTextLabel?.text = (mark.administrativeArea ?? "") + (mark.locality ?? "") + detailLocationName
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - UISearchResultsUpdating, UISearchControllerDelegate
extension FindLocationViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    func willDismissSearchController(_ searchController: UISearchController) {
    }
}

// MARK: - CLLocationManagerDelegate
extension FindLocationViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .denied:
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            placeName(location: location) { (mark) in
                self.searchDataSource.append(mark!)
                self.tableview.reloadData()
            }
            print("緯度:\(location.coordinate.latitude) 経度:\(location.coordinate.longitude) 取得時刻:\(location.timestamp.description)")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

