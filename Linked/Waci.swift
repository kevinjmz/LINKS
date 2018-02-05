//
//  Waci.swift
//  Linked
//
//  Created by Gerardo Cervantes on 9/20/16.
//  Copyright © 2016 Gerardo Cervantes. All rights reserved.
//

import Foundation
import UIKit


/**URLSessionDelegate expect NSObjects, so must inherit NSObject to be able to inherit from URLSessionDelegate*/
class Waci: NSObject, URLSessionDelegate{
    
    
    /**The IP Address that will be used to connect to the Waci, has a setter method*/
    private final var ipAddress: String = "192.168.100.100" /**Default IP*/
    
    /**All commands with prefix TAND have to do with codec*/
    
    
    /**Sends a message/command to the Waci
     Uses last IP address that was set
     Waci should be programmed with commands
     
     - parameters:
        -waciCommand: the command that you want to send to waci*/
    func sendWaciCommand(waciCommand: String){
        print("Sending Waci command: " )
        print(waciCommand)
        
        let request = createRequestDaniel(waciCommand: waciCommand)
        
        
        /*let sessionConnection = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            //Handle data returned here
            }
        )
         
        /**Starts connection in new thread*/
        sessionConnection.resume()
 */
        startSessionWithRequest(request)
    }
    
    /**Creates the request that will be sent to the Waci (in a url)*/
    private func createRequest(waciCommand: String) -> URLRequest{
        
        let request: NSMutableURLRequest = NSMutableURLRequest()
        request.url = URL(string: "http://"+ipAddress+"/rpc")!
        request.httpMethod = "POST"
        //request.addValue(String(format: "text/xml"), forHTTPHeaderField: "Content-Type")
        let postBody: NSMutableData = NSMutableData() //Changed form var to let
        
        postBody.append("method=TriggerEventByName&Param1=\(waciCommand)&Param2=0&Param3=0&Param4=0".data(using: String.Encoding.utf8)!)
        
        request.httpBody = postBody as Data
        return request as URLRequest
    }
    
    private func createRequestDaniel(waciCommand: String) -> URLRequest{
        let myUrl = URL(string: "http://\(ipAddress)/rpc/")
        print("http://\(ipAddress)/rpc/")
        let postString = "method=TriggerEventByName&Param1=\(waciCommand)&Param2=0&Param3=0&Param4=0";
        
        let request = NSMutableURLRequest(url:myUrl!);
        request.httpMethod = "POST";
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        //print(request.HTTPBody)
        print("WACI sent is: \(waciCommand)")
        
        return request as URLRequest
    }
    
    private func createRequestBest(waciCommand: String) -> URLRequest{
        var request = URLRequest(url: URL(string: "http://"+ipAddress+"/rpc")!)
        
        request.httpMethod = "POST"
        let post = "method=TriggerEventByName&Param1=\(waciCommand)&Param2=0&Param3=0&Param4=0"
        request.httpBody = post.data(using: .utf8)
        return request
    }
    
    private func startSessionWithRequest(_ request: URLRequest)
    {
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in
            
            //DEBUGGING PURPOSES
            //            if error != nil
            //            {
            //                print("error=\(error)")
            //                return
            //            }
            //            // You can print out response object
            //            print("response = \(response)")
            //            // Print out response body
            //            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //            print("responseString = \(responseString)")
        }) 
        
        task.resume()
    }
    
    private func startSessionWithRequest2(_ request: URLRequest)
    {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        
        task.resume()
    }
    
}
