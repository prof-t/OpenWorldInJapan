//
//  ViewController.swift
//  OpenWorldInJapan
//
//  Created by 平山亮 on 2017/05/07.
//  Copyright © 2017年 平山亮. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    let startPointStr = "東京駅"
    let coodinateOf1km = 0.0090133729745762
    var characterCoordinate:CLLocationCoordinate2D? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        settingStartPoint(startPointStr)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var displayMap: MKMapView!
    
    @IBAction func tappedUpperButton(_ sender: Any) {
        self.characterCoordinate?.latitude = (self.characterCoordinate?.latitude)! + self.coodinateOf1km
        self.displayMap.region = MKCoordinateRegionMakeWithDistance(self.characterCoordinate!, 2000.0, 2000.0)
    }
    
    @IBAction func tappedLeftButton(_ sender: Any) {
        self.characterCoordinate?.longitude = (self.characterCoordinate?.longitude)! - self.coodinateOf1km
        self.displayMap.region = MKCoordinateRegionMakeWithDistance(self.characterCoordinate!, 2000.0, 2000.0)
    }
    
    @IBAction func tappedRightButton(_ sender: Any) {
        self.characterCoordinate?.longitude = (self.characterCoordinate?.longitude)! + self.coodinateOf1km
        self.displayMap.region = MKCoordinateRegionMakeWithDistance(self.characterCoordinate!, 2000.0, 2000.0)
    }
    
    @IBAction func tappedDownButton(_ sender: Any) {
        self.characterCoordinate?.latitude = (self.characterCoordinate?.latitude)! - self.coodinateOf1km
        self.displayMap.region = MKCoordinateRegionMakeWithDistance(self.characterCoordinate!, 2000.0, 2000.0)
    }
    
    //スタート地点設定
    fileprivate func settingStartPoint(_ pointName: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(pointName) { (placemarks:[CLPlacemark]?, error:Error?) in
            if let placemark = placemarks?[0] {
                if let targetCoodinate = placemark.location?.coordinate {
                    print(targetCoodinate)
                    self.characterCoordinate = targetCoodinate
                    let pin = MKPointAnnotation()
                    pin.coordinate = self.characterCoordinate!
                    pin.title = pointName
                    self.displayMap.addAnnotation(pin)
                    self.displayMap.region = MKCoordinateRegionMakeWithDistance(self.characterCoordinate!, 2000.0, 2000.0)
                    self.displayMap.mapType = .hybrid
                    
                }
            }
        }
    }
}

