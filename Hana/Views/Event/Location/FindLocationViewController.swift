//
//  FindLocationViewController.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/16.
//

import UIKit
import CoreLocation
import MapKit
import RxSwift

class LocationModel {
    var name: String?
    var address: String?
    var location: CLLocationCoordinate2D?
}

fileprivate enum Section: Int {
    case current = 0
    case search = 1
    static var count = 2
}

class FindLocationViewController: UIViewController {

    let locationCellIdentifier = R.reuseIdentifier.locationCell.identifier
    var searchController = UISearchController(searchResultsController: nil)
    var locationManager = CLLocationManager()
    var localSearchs = Variable<[LocationModel]>([LocationModel]())
    var searchLocations = Variable<[LocationModel]>([LocationModel]())
    var event: Event!
    let disposeBag = DisposeBag()

    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    func setup() {
        locationManager.delegate = self
        //locationManager.requestLocation()

        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 100
        tableview.register(R.nib.locationCell(), forCellReuseIdentifier: locationCellIdentifier)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "placeholder"
        tableview.tableFooterView = UIView()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        reverseGeocode(location: locationManager.location)

        searchLocations.asObservable().subscribe { (model) in
            self.tableview.reloadData()
        }.disposed(by: disposeBag)
        
        localSearchs.asObservable().subscribe { (model) in
            self.tableview.reloadData()
            }.disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedCancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Navigation

extension FindLocationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Section.current.rawValue {
            return localSearchs.value.count
        }
        return searchLocations.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableview.dequeueReusableCell(withIdentifier: locationCellIdentifier, for: indexPath) as? LocationCell {
            let mark = searchLocations.value[indexPath.row]
            if indexPath.section == Section.current.rawValue && indexPath.row == 0 {
                cell.imageView?.image = #imageLiteral(resourceName: "icon_location_ current")
            } else {
                cell.imageView?.image = #imageLiteral(resourceName: "icon_location_pointer")
            }
            cell.textLabel?.text = mark.name
            if indexPath.section != Section.current.rawValue {
                cell.detailTextLabel?.text = mark.address
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UISearchResultsUpdating, UISearchControllerDelegate
extension FindLocationViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchString = searchController.searchBar.text, !searchString.isBlank {
            geocodeAddress(name: searchString)
        }
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
            //locationManager.startUpdatingLocation()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for location in locations {
            reverseGeocode(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}

// MARK: - GEO
extension FindLocationViewController {
    
    func geocodeAddress(name: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { (placemarks, error) in
            if error == nil {
                if let placemarks = placemarks {
                    for placemark in placemarks {
                        self.searchAround(query: name, coordinate: placemark.location!.coordinate)
                    }
                }
            }
        }
    }
    
    func searchAround(query: String, coordinate: CLLocationCoordinate2D) {
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = query
        request.region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000)
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            if let mapItems = response?.mapItems {
                self.searchLocations.value.removeAll()
                for item in mapItems {
                    let model = LocationModel()
                    model.name = item.placemark.name ?? ""
                    model.address = item.placemark.address
                    model.location = item.placemark.coordinate
                    self.searchLocations.value.append(model)
                }
            }
        }
        
    }
    
    
    
    func reverseGeocode(location: CLLocation?) {
        // Use the last reported location.
        if let lastLocation = location {
            let geocoder = CLGeocoder()
            
            // Look up the location and pass it to the completion handler
            geocoder.reverseGeocodeLocation(lastLocation,
                                            completionHandler: { (placemarks, error) in
                                                if error == nil {
                                                    
                                                    if let placemarks = placemarks {
                                                        for placemark in placemarks {
                                                            let model = LocationModel()
                                                            model.name = placemark.name ?? ""
                                                            model.address = placemark.address
                                                            model.location = placemark.location?.coordinate
                                                            self.localSearchs.value.append(model)
                                                            return
                                                        }
                                                    }
                                                }
            })
        }
    }
    
}

// MARK: - CLPlacemark

extension CLPlacemark {
    var address: String {
        let components = [self.administrativeArea, self.locality, self.thoroughfare, self.subThoroughfare]
        return components.compactMap { $0 }.joined(separator: "")
    }

}

