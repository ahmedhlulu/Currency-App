//
//  Currency.swift
//  Currency App
//
//  Created by Ahmed on 07/05/2022.
//

import Foundation
import Alamofire

var myRates:[Double] = [0,0,0,0,0,0,0,0,0]

let arrCurrencyName = ["USD","ILS","EUR","EGP","AED","JOD","SAR","TRY","CNY"]

let arrCurrencyNameAR = ["الدولار الامريكي","شيكل","يورو","جنيه مصري","درهم اماراتي","دينار اردني","ريال سعودي","ليرة تركية","يوان صيني"]

var myCurrency = "USD"
var myKey = "2dd333efca9a0ca9c653fdfe"

func getCurrency(){
    
    AF.request("https://v6.exchangerate-api.com/v6/\(myKey)/latest/\(myCurrency)").responseJSON(completionHandler: { response in
        if let result = response.value as? NSDictionary {
            
            let JSONDectionary = result["conversion_rates"] as! NSDictionary
            myRates[0] = (JSONDectionary["USD"] as! Double)
            myRates[1] = (JSONDectionary["ILS"] as! Double)
            myRates[2] = (JSONDectionary["EUR"] as! Double)
            myRates[3] = (JSONDectionary["EGP"] as! Double)
            myRates[4] = (JSONDectionary["AED"] as! Double)
            myRates[5] = (JSONDectionary["JOD"] as! Double)
            myRates[6] = (JSONDectionary["SAR"] as! Double)
            myRates[7] = (JSONDectionary["TRY"] as! Double)
            myRates[8] = (JSONDectionary["CNY"] as! Double)
            
            NotificationCenter.default.post(Notification(name: Notification.Name("DataIsHere"),
                                                         object: nil,
                                                         userInfo: nil))
        }
    })
    
}
