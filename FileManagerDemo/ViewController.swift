//
//  ViewController.swift
//  FileManagerDemo
//
//  Created by ramjan sayyad on 25/09/18.
//  Copyright © 2018 ramjan sayyad. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var imageView2: UIImageView!
    
    var imagePicker: UIImagePickerController!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be .
    }

    @IBAction func imageAction(_ sender: Any) {
       
       
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            imagePickerController.sourceType  = .camera
            
            self.present(imagePickerController, animated: true, completion: nil)
        }
        else{
            print("Camera  not avaliable")
        }
        
        
        
    }
    
    
    
    @IBAction func saveAction(_ sender: Any) {
        
         UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    //MARK: - Add image to Library
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
            
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    
    //MARK: - Done image capture here
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("pics.jpg")
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
        
        DispatchQueue.main.async() {
            print("Photo Saved")
        }
    }
    
    func getDirectoryPath() -> String {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        
        let documentsDirectory = paths[0]; return documentsDirectory
        
    }
    
    @IBAction func savedAction(_ sender: Any) {
        
       
            
            let fileManager = FileManager.default
            
            let imagePAth = (self.getDirectoryPath() as NSString).appendingPathComponent("pics.jpg")
            
            if fileManager.fileExists(atPath: imagePAth){
                
                self.imageView2.image = UIImage(contentsOfFile: imagePAth)
                
            }else{
                
                print("No Image")
                

            
        }
            
         
            
    }
        
       
    
    
    

    @IBAction func createAction(_ sender: Any) {
        

            
            let fileManager = FileManager.default
            
            let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("CustomDirectory")
            
            if !fileManager.fileExists(atPath: paths){
                
                try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
                
                print("Dictionary Created")
                print(paths)
            }else{
                
                print("Already dictionary created.")
                
            }
            
        }
        

        
    
    
    
    
//func deleteAction(_ sender: Any) {
//
//
//
//            let fileManager = FileManager.default
//
//            let paths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString).stringByAppendingPathComponent("CustomDirectory”)
//
//            if fileManager.fileExistsAtPath(paths){
//
//                try! fileManager.removeItemAtPath(paths)
//
//            }else{
//
//                print("Something wronge”)
//
//            }
//
//        }
//    

    
}
    


