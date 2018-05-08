//
//  ViewController.swift
//  FolledoAllUdemyAppBuild-20-Apps
//
//  Created by Samuel Folledo on 4/26/18.
//  Copyright © 2018 Samuel Folledo. All rights reserved.
//

//Load images from online and reuse them
import UIKit

class ViewController: UIViewController {
    
//viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=a8d45e0155d745e7ae0c57539dcae2ea")
        
        //create a task from a URL without having to create a request
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in //from the url
            
            if error != nil {
                print(error!)
            } else {
                if let urlContent = data { //this url content is going to be JSON
                    
                    do { //JSONSerialization is something that can go wrong if your data is malformed, so we need to surround it with do-try-catch
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject //JSONSerialization is an object that converts between JSON and the equivalent Foundation objects. You use the JSONSerialization class to convert JSON to Foundation objects and convert Foundation objects to JSON.
                        print(jsonResult)
                        
                        print(jsonResult["name"]) //to print out the name
                        
                        //simplest way to extract description
                        if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {//0 because weather is considered as an array with only one object, and that object is a dictionary from which we can grab the description
                            print(description)
                        }
                        
                    } catch { print("JSON Processing failed") }
                }
            }
            
        }
        task.resume()
        
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

