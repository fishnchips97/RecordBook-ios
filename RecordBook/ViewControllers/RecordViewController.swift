//
//  RecordViewController.swift
//  RecordBook
//
//  Created by Erik Fisher on 11/29/18.
//  Copyright © 2018 Berk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RecordViewController: UIViewController, CLLocationManagerDelegate {
    
    var playButton: UIButton!
    var mapView: MKMapView!
    var toggleState = 1
    var locationManager = CLLocationManager()
    var regionRadius: CLLocationDistance = 1000 //Map bounding box 1000 meters
    var miles: UILabel!
    var milesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI() {
        setUpNavBar()
        setUpMapView()
        setUpLocationManager()
        setUpStats()
        setUpPlayButton()
    }
    
    func setUpNavBar() {
        self.navigationController?.navigationBar.barTintColor = Constants.lightBlueColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 26)]
        self.navigationItem.title = "Run"
        
    }
    
    func setUpMapView() {
        mapView = MKMapView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: view.frame.height/3))
        view.addSubview(mapView)
    }
    
    func setUpLocationManager() {
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // Everytime location is updated
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        let coordinateRegion = MKCoordinateRegion(center: locValue,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.showsUserLocation = true

    }
    
    func setUpStats() {
        miles = UILabel(frame: CGRect(x: view.frame.width/2, y: mapView.frame.maxY + 20, width: 30, height: 30))
        miles.text = "0.00"
        miles.textColor = .black
        miles.font = UIFont.boldSystemFont(ofSize: 70)
        miles.sizeToFit()
        miles.frame.origin.x -= miles.frame.width/2
        view.addSubview(miles)
        
        milesLabel = UILabel(frame: CGRect(x: view.frame.width/2, y: miles.frame.maxY, width: 30, height: 30))
        milesLabel.text = "MILES"
        milesLabel.textColor = Constants.darkGrayColor
        milesLabel.font = UIFont.boldSystemFont(ofSize: 18)
        milesLabel.sizeToFit()
        milesLabel.frame.origin.x -= milesLabel.frame.width/2
        view.addSubview(milesLabel)
    }
    

    
    func setUpPlayButton() {
        playButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 45, y: (self.tabBarController?.tabBar.frame.minY)! - 110, width: 90, height: 90))
        playButton.backgroundColor = Constants.lightBlueColor
        playButton.layer.cornerRadius = playButton.frame.width / 2 // make it a circle
        playButton.layer.masksToBounds = true
        playButton.setImage(UIImage(named: "play-button"), for: .normal)
        playButton.imageEdgeInsets = UIEdgeInsets(top: 25, left: 30, bottom: 25, right: 25) //make image smaller
        playButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        playButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        playButton.layer.shadowColor = UIColor.black.cgColor
        playButton.layer.shadowOpacity = 0.3
        playButton.layer.shadowRadius = 3
        playButton.layer.masksToBounds = false
        view.addSubview(playButton)
    }
    
    @objc func buttonPressed() {
        if toggleState == 1 {
            // Start recording
            toggleState = 2
            playButton.setImage(UIImage(named: "pause-button"), for: .normal)
            playButton.imageEdgeInsets.left = 25
        } else {
            // Stop recording
            toggleState = 1
            playButton.setImage(UIImage(named: "play-button"), for: .normal)
            playButton.imageEdgeInsets.left = 30
        }
    }
    
}
