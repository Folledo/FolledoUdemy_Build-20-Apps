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
    
    
    @IBOutlet var bachImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//restoring image //EASTWOOD
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        if documentsPath.count > 0 {
            let documentDirectory = documentsPath[0]
            let restorePath = documentDirectory + "/bach.jpg"
            //now we make a UIImage from a file
            bachImageView.image = UIImage(contentsOfFile: restorePath)
/*
            // THIS IS FOR SAVEPATH, but doesnt need do-try-catch
                try UIImageJPEGRepresentation(bachImage, 1)?.write(to: URL(fileURLWithPath: savePath)) //quality is 0-1, for best quality, put in 1 //then take that image and write it to a url, and the url is going to be a url from a file with the path savePAth
 */
            
            
        }
        
        
        
        let url = URL(string: "https://www.tokyoshop.es/data/productos/merchandising/MERCH4969-D.jpg")
        let request = NSMutableURLRequest(url: url!)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { //URLSession is like opening a browser window to go online and download some data (in here is image)
            data, response, error in
            
            if error != nil {
                print (error!)
            } else {
                if let data = data {
                    if let bachImage = UIImage(data: data) {
                        self.bachImageView.image = bachImage //now display the image to the UIImageView
                        
                        //Next thing to do is save the image locally in the device so that the next time the app is loaded the image is restored not from the web but from the device itself
                        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) //serch for local directories on within the app itself, and we are searching for .documentDirectory. This domain mask is where we're looking for our files where we're seaching for, and we want to search relative to the user's home directory. //NSSearchPathForDirectoriesInDomains Creates a list of directory search paths. //Creates a list of path strings for the specified directories in the specified domains. The list is in the order in which you should search the directories. If expandTilde is true, tildes are expanded as described in expandingTildeInPath. //Note = The directory returned by this method may not exist. This method simply gives you the appropriate location for the requested directory. Depending on the application’s needs, it may be up to the developer to create the appropriate directory and any in between.
                        //documentPath should search for a path, and return a single path, but it is worth checking
                        if documentsPath.count > 0 {
                            
//saving the image
                            let documentDirectory = documentsPath[0]
                            let savePath = documentDirectory + "/bach.jpg"
                            do {
                            try UIImageJPEGRepresentation(bachImage, 1)?.write(to: URL(fileURLWithPath: savePath)) //quality is 0-1, for best quality, put in 1 //then take that image and write it to a url, and the url is going to be a url from a file with the path savePAth
                            } catch {
                                print("No UIImageJPEGRepresentation found")
                            }
                            
                        }
                    }
                }
            }
        }
        task.resume()//what actually runs the task
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
}


