//
//  MapDelegate.swift
//  Chuh-chuh
//
//  Created by Volodymyr Hryhoriev on 11/19/17.
//  Copyright © 2017 Nobles Team. All rights reserved.
//

import UIKit
import MapKit

class MapDelegate: NSObject, MKMapViewDelegate {
    
    let identifier = "PlaceAnnotation"
    
    var mapView: MKMapView!
    
    var places: [Place] = [] {
        didSet {
            annotations = places.map { PlaceAnnotation(coordinate: CLLocationCoordinate2D(latitude: $0.location.latitude, longitude: $0.location.longitude), place: $0) }
        }
    }
    
    var annotations: [PlaceAnnotation] = [] {
        didSet {
            mapView.addAnnotations(annotations)
        }
    }
    
    // MARK: MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        var pin = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if pin == nil {
            pin = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pin?.image = #imageLiteral(resourceName: "ic_map_pin_big")
            pin?.canShowCallout = true
            pin?.centerOffset = CGPoint(x: 0, y: -(pin!.image!.size.width / 2))
        } else {
            pin?.annotation = annotation
        }
        
        self.configureCallout(pin!)
        
        return pin
    }

    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // TODO
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        // TODO: check
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = view.annotation as? PlaceAnnotation else {
            return
        }
        
        SplashRouter.shared.showPlaceDetails(annotation.place)
    }
    
    private func configureCallout(_ pin: MKAnnotationView) {
        let detailButton = UIButton(type: .detailDisclosure)
        var frame = detailButton.frame
        frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width / 2, height: frame.height / 2)
        detailButton.frame = frame
        detailButton.setImage(nil, for: .normal)

        pin.rightCalloutAccessoryView = detailButton
        
        let annotation = pin.annotation as! PlaceAnnotation
        
        let image = UIImage(fileUrl: URL(string: annotation.place.image)!)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        imageView.layer.cornerRadius = 6.0
        
        pin.leftCalloutAccessoryView = imageView
        
        let raterView = RaterView()
        raterView.frame = CGRect(x: 0, y: 0, width: 80, height: 20)
        raterView.isUserInteractionEnabled = false
        
        pin.detailCalloutAccessoryView = raterView
    }
    
//    - (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
//    VGPost *post = (VGPost*)view.annotation;
//    self.postId = post.postId;
//    [self performSegueWithIdentifier:@"VGPostDetailViewController" sender:nil];
//    }
    
//      - (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//    if (!self.firstTimeRendered) {
//    [self removeOldAnnotations];
//    [self getPostsWithoutUserLocation];
//    }
//    }
//
//    - (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
//    if (self.firstTimeRendered && fullyRendered)
//    self.firstTimeRendered = NO;
//    }
    
//    #pragma mark - Edit annotations
//
//    - (void)removeOldAnnotations {
//    MKMapRect visibleRect = self.mapView.visibleMapRect;
//    NSArray<VGPost<MKAnnotation> *> *allAnnotations = [self.mapView annotations];
//    NSSet <VGPost<MKAnnotation> *> *annotations = [self.mapView annotationsInMapRect:visibleRect];
//
//    for (VGPost<MKAnnotation> *post in allAnnotations) {
//    if (![annotations containsObject:post])
//    [self.mapView removeAnnotation:post];
//    }
//    }
//
//    - (void)addNewAnnotations {
//    NSArray <VGPost<MKAnnotation> *> *allAnnotations = self.mapView.annotations;
//    for (VGPost<MKAnnotation> *post in self.posts) {
//    if (![allAnnotations containsObject:post])
//    [self.mapView addAnnotation:post];
//    }
//    }
    
}
