//
//  CustomFunctions.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import CoreLocation

class CustomFunctions {
    
    public func getAddressFromLocation(latitude: Double?, longitude: Double?, completion: @escaping (String) -> Void) {
        
        guard let lat = latitude, let long = latitude  else {
            completion("")
            return
        }
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = long
        
        //Example
        //center.latitude = -27.608919
        //center.longitude = -48.450612

        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        ceo.reverseGeocodeLocation(
            loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        completion("")
                    }
                    
                    if let placemarks = placemarks, let pm = (placemarks as [CLPlacemark]?), pm.count > 0 {
                        
                        let pm = placemarks[0]
                        
                        var addressString : String = ""
                        if let subLocality = pm.subLocality {
                            addressString.append(subLocality + ", ")
                        }
                        if let thoroughfare = pm.thoroughfare {
                            addressString.append(thoroughfare + ", ")
                        }
                        if let locality = pm.locality {
                            addressString.append(locality + ", ")
                        }
                        if let country = pm.country {
                            addressString.append(country + ", ")
                        }
                        if let postalCode = pm.postalCode {
                            addressString.append(postalCode + " ")
                        }
                        
                        completion(addressString)
                        
                    } else {
                        completion("")
                    }
                })
        
    }
    
    public func formatSharedMsg(movie: Movie, completion: @escaping(String) -> Void){

        var shareText = movie.title ?? ""

        if let dateStr = movie.date?.epochToDateStr() {
            shareText.append("\n" + NSLocalizedString("Release date: ", comment: "") + dateStr)
        }
        if let timeStr = movie.date?.epochToTimeStr() {
            shareText.append("\n" + NSLocalizedString("Time: ", comment: "") + timeStr)
        }
        completion(shareText)
    }
    
    public func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
