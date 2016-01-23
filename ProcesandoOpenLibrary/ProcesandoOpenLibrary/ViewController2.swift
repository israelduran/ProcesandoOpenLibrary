//
//  ViewController2.swift
//  ProcesandoOpenLibrary
//
//  Created by Andres Sanchez Delgado on 22/01/16.
//  Copyright © 2016 Israel Durán Martínez. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var web: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = NSURL(string: "https://covers.openlibrary.org/b/id/600725-S.jpg")
        
        web.loadHTMLString("Prueba", baseURL: url)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
