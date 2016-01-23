//
//  ViewController.swift
//  ProcesandoOpenLibrary
//
//  Created by Andres Sanchez Delgado on 22/01/16.
//  Copyright © 2016 Israel Durán Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var txtISBN: UITextField!
    @IBOutlet weak var labelTitulo: UILabel!
    @IBOutlet weak var textViewAutores: UITextView!
    @IBOutlet weak var imagePortada: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func alertaDeError(){
        let alerta = UIAlertController(title: "Error de conexión", message: "Ha habido un error al tratar de obtener la información relacionada al ISBN. Verifica tu conexión a internet.", preferredStyle: UIAlertControllerStyle.Alert)
        alerta.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            alerta.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        presentViewController(alerta, animated: true, completion: nil)
    }

    /*func sincrono(ISBN : String) -> NSData
    {
        
        //return datos!
        
        //print(datos)
        
        /*if(datos != nil)
        {
            let jsonUTF8 = NSString(data:datos!, encoding: NSUTF8StringEncoding)
            print(jsonUTF8)
            do
            {
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let dic1 = json as! NSDictionary
                print(dic1)
                //let dic2 = dic1["ISBN:978-84-376-0494-7"] as! NSDictionary
                let dic2 = dic1[cadenaISBN] as! NSDictionary
                //let dic3 = dic2["publishers"] as! NSArray
                
                
                
                let dic4 = dic2["authors"] as! NSArray
                
                for i in 0 ..< dic4.count
                {
                    let dic5 = dic4[i] as! NSDictionary
                    
                    if i == 0
                    {
                        autores = dic5["name"] as! NSString as String
                    }
                    else
                    {
                        autores = autores + "\n" + (dic5["name"] as! NSString as String)
                    }
                }
                
                print(autores)
                //let dic5 = dic4[0] as! NSDictionary
                
                //print(dic2["pagination"] as! NSString as String)
                //print(dic2["title"] as! NSString as String)
                
                labelTitulo.text = dic2["title"] as! NSString as String
                //labelAutores.text = dic5["name"] as! NSString as String
                //print(dic5["name"])
            }
            catch _{}
        }
        else
        {
            print("alertaDeError()");
            alertaDeError()
        
        }*/
        
        //return texto as! String
    }*/
    
    @IBAction func txtActionISBN(sender: UITextField)
    {
        self.resignFirstResponder()
        
        //print(sender.text!)
        
        var cadenaISBN : String
        var autores : String = "Sin autores"
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:";
        let url = NSURL(string: urls + sender.text!)
        let datos : NSData? = NSData(contentsOfURL: url!)
        cadenaISBN = "ISBN:" + sender.text!

        if(datos != nil)
        {
            let jsonUTF8 = NSString(data:datos!, encoding: NSUTF8StringEncoding)
            print(jsonUTF8)
            do
            {
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                let dic1 = json as! NSDictionary
                print(dic1)
                //ISBN
                let dic2 = dic1[cadenaISBN] as! NSDictionary
                
                if dic2["authors"] != nil
                {
                    //Autores
                    let dic4 = dic2["authors"] as! NSArray
                    
                    for i in 0 ..< dic4.count
                    {
                        let dic5 = dic4[i] as! NSDictionary
                    
                        if i == 0
                        {
                            autores = dic5["name"] as! NSString as String
                        }
                        else
                        {
                            autores = autores + "\n" + (dic5["name"] as! NSString as String)
                        }
                    }
                }
                print(autores)
                
                //Cover
                let dicCover = dic2["cover"]
                print(dicCover)
                if dicCover != nil
                {
                    let cover = dicCover as! NSDictionary
                    //print(cover)
                    
                    let portada = cover["medium"] as! NSString as String
                    
                    let url = NSURL(string: portada)
                    if let data = NSData(contentsOfURL: url!)
                    {
                        imagePortada.image = UIImage(data: data)
                    }
                }
                else
                {
                    imagePortada.image = UIImage(contentsOfFile: "Sin_imagen_disponible")
                    print("Sin imagen")
                }
                
                //print(portada)
                
                labelTitulo.text = dic2["title"] as! NSString as String
                textViewAutores.text = autores
                
            }
            catch _{}
        }
        else
        {
            alertaDeError()
        }
    }
}
