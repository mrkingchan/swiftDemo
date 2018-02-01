//
//  MapVC.swift
//  swiftDemo
//
//  Created by Chan on 2018/2/1.
//  Copyright © 2018年 Chan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    var map:MKMapView?;
    var manager:CLLocationManager?;
    var geo:CLGeocoder?;
    var userLocation:CLLocationCoordinate2D?;

    override func viewDidLoad() {
        super.viewDidLoad();
        self.view.backgroundColor = UIColor.white;
        self.geo = CLGeocoder.init();
        self.geo?.geocodeAddressString("深圳市宝安区西乡街道") { (places, error) in
            if error == nil {
                let placeArray:[CLPlacemark] = places!;
                let location = placeArray.first?.location;
                print(String.init(format: "longitude = %.3f,latitude = %.3f", Float((location?.coordinate.longitude)!),Float((location?.coordinate.latitude)!)));
            }

        }
        // MARK: mapView
        self.map = MKMapView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 64));
        self.map?.mapType = MKMapType.standard;
        self.map?.showsScale = true;
        self.map?.showsCompass = true;
        self.map?.showsUserLocation = true;
        self.map?.showsTraffic = true;
        self.map?.delegate = self as MKMapViewDelegate;
        self.view.addSubview(self.map!);
        
        // MARK: manager
        
        if #available(iOS 11.0, *) {
            self.manager?.showsBackgroundLocationIndicator = true
        }
        if CLLocationManager.locationServicesEnabled() {
            self.manager = CLLocationManager.init();
            self.manager?.distanceFilter = 10.0;
            self.manager?.desiredAccuracy = 10.0;
            self.manager?.requestWhenInUseAuthorization();
            self.manager?.requestAlwaysAuthorization();
        } else {
            let alertController = UIAlertController.init(title: "定位被拒绝，请前往设置打开", message:nil, preferredStyle: UIAlertControllerStyle.alert);
            for _ in 0..<1 {
                let alertAction = UIAlertAction.init(title:"确定", style: UIAlertActionStyle.default) { action in
                };
                alertController.addAction(alertAction);
            }
            self.present(alertController, animated: true, completion: nil);
        }
        self.manager?.delegate = self as CLLocationManagerDelegate;
        self.manager?.startUpdatingLocation();
    }
    
    // MARK: mapViewDelegate
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print(#function);
    }
    func mapViewWillStartLocatingUser(_ mapView: MKMapView) {
        print(#function);
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        self.map?.setRegion(MKCoordinateRegion.init(center: userLocation.coordinate, span: MKCoordinateSpan.init(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: true);
    }
    
    // MARK: CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print(#function);
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print(#function);
    }
    
}
