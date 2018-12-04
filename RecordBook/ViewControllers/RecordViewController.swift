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
    var startLocation: CLLocation!
    var lastLocation: CLLocation!
    var traveledDistance: Double = 0
    var miles: UILabel!
    var milesLabel: UILabel!
    var timeIcon: UIImageView!
    var timeLabel: UILabel!
    var paceIcon: UIImageView!
    var paceLabel: UILabel!
    var smallTextFont: CGFloat = 25
    weak var timer: Timer? //set to weak so becomes nil when invalidated
    var seconds = 0 {
        didSet {
            if seconds < 10 {
                timeLabel.text = "00:0\(seconds)"
            } else {
                timeLabel.text = "00:\(seconds)"
            }
        }
    }
    var speed = CLLocationSpeed()
    var shouldUpdateSpeed = false
    var shouldUpdateDistance = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        //make sure timer stops when view controller dismissed
        timer?.invalidate()
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
        self.navigationController?.navigationBar.tintColor = .white
        let refreshImage = UIImage(named: "refresh")
        refreshImage!.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: refreshImage, style: .plain, target: self, action: #selector(resetStats))
        
    }
    
    // Resets everthing to 0
    @objc func resetStats() {
        if toggleState == 1 {
            // can only reset when run finished
            miles.text = "0.00"
            paceLabel.text = "00:00"
            timeLabel.text = "00:00"
            seconds = 0
            traveledDistance = 0
            timer?.invalidate()
        }
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
        if startLocation == nil {
            startLocation = locations.first
        } else if let location = locations.last {
            if shouldUpdateDistance {
                traveledDistance += lastLocation.distance(from: location)
                convertToMile(distance: traveledDistance)
            }
            
        }

    }
    
    func setUpStats() {
        miles = UILabel(frame: CGRect(x: view.frame.width/2, y: mapView.frame.maxY + 20, width: 30, height: 30))
        miles.text = "0.00"
        miles.textColor = .black
        miles.font = UIFont.boldSystemFont(ofSize: 100)
        miles.sizeToFit()
        miles.frame.origin.x -= miles.frame.width/2
        view.addSubview(miles)

        milesLabel = UILabel(frame: CGRect(x: view.frame.width/2, y: miles.frame.maxY, width: 30, height: 30))
        milesLabel.text = "MILES"
        milesLabel.textColor = Constants.darkGrayColor
        milesLabel.font = UIFont.systemFont(ofSize: smallTextFont)
        milesLabel.sizeToFit()
        milesLabel.frame.origin.x -= milesLabel.frame.width/2
        view.addSubview(milesLabel)
        
        // Add horizontal line
        let horizontalLine = UIView(frame: CGRect(x: 10, y: milesLabel.frame.maxY + 15, width: view.frame.width - 20, height: 1))
        horizontalLine.layer.borderWidth = 4
        horizontalLine.layer.borderColor = Constants.lightGrayColor.cgColor
        view.addSubview(horizontalLine)
        
        // Add vertical line in between pace and time
        let verticalLine = UIView(frame: CGRect(x: view.frame.width/2, y: horizontalLine.frame.maxY + 20, width: 1, height: 60))
        verticalLine.layer.borderWidth = 4
        verticalLine.layer.borderColor = Constants.lightGrayColor.cgColor
        view.addSubview(verticalLine)
        
        // Set up time
        timeIcon = UIImageView(frame: CGRect(x: view.frame.width*0.25 - 10, y: horizontalLine.frame.maxY + 20, width: 20, height: 20))
        timeIcon.image = UIImage(named: "stopwatch")
        view.addSubview(timeIcon)
        timeLabel = UILabel(frame: CGRect(x: view.frame.width*0.25, y: timeIcon.frame.maxY + 10, width: 30, height: 30))
        timeLabel.text = "00:00"
        timeLabel.textColor = .black
        timeLabel.font = UIFont.boldSystemFont(ofSize: smallTextFont + 5)
        timeLabel.sizeToFit()
        timeLabel.frame.origin.x -= timeLabel.frame.width/2
        view.addSubview(timeLabel)
        
        // Set up pace
        paceIcon = UIImageView(frame: CGRect(x: view.frame.width*0.75 - 10, y: horizontalLine.frame.maxY + 20, width: 20, height: 20))
        paceIcon.image = UIImage(named: "pace")
        view.addSubview(paceIcon)
        paceLabel = UILabel(frame: CGRect(x: view.frame.width*0.75, y: timeIcon.frame.maxY + 10, width: 30, height: 30))
        paceLabel.text = "00:00"
        paceLabel.textColor = .black
        paceLabel.font = UIFont.boldSystemFont(ofSize: smallTextFont + 5)
        paceLabel.sizeToFit()
        paceLabel.frame.origin.x -= paceLabel.frame.width/2
        view.addSubview(paceLabel)
        
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
            startTimer()
        } else {
            // Stop recording
            toggleState = 1
            playButton.setImage(UIImage(named: "play-button"), for: .normal)
            playButton.imageEdgeInsets.left = 30
            stopTimer()
        }
        shouldUpdateSpeed = !shouldUpdateSpeed
        shouldUpdateDistance = !shouldUpdateDistance
    }
    
    func startTimer() {
        timer?.invalidate()   // stops previous timer, if any
        let seconds = 1.0 //interval
        timer = Timer.scheduledTimer(timeInterval: seconds, target: self, selector: #selector(incrementTime(_:)), userInfo: nil, repeats: true)
        
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
    @objc func incrementTime(_ timer: Timer) {
        seconds += 1
        speed = locationManager.location!.speed
        if shouldUpdateSpeed {
            convertToMilePace(speed: speed)
        }
    }
    
    func convertToMilePace(speed: CLLocationSpeed) {
        let doubleSpeed = abs(Double(speed))
        let mph = doubleSpeed * 3600 * 0.00062
        let mileTime = 60 / mph
        let minutes = floor(mileTime)
        let seconds = Int(floor((mileTime - minutes) * 60)) //gets seconds
        if seconds < 10 {
            paceLabel.text = "\(Int(minutes)):0\(seconds)"
        } else {
            paceLabel.text = "\(Int(minutes)):\(seconds)"
        }
    }
    
    func convertToMile(distance: CLLocationDistance) {
        let doubleDistance = abs(Double(distance))
        let miles = doubleDistance * 0.00062
        let rounded = Double(round(100*miles)/100)
        milesLabel.text = "\(rounded)"
    }
    
    
}
