//
//  CamViewController.swift
//  textSpeaker
//
//  Created by Changyao Huang on 2/26/17.
//  Copyright © 2017 KaWing. All rights reserved.
//

import UIKit
import TesseractOCR


class CamViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , G8TesseractDelegate{

    var stringController:StringController!
    
    @IBOutlet weak var pickedImaged: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func camActionButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    @IBAction func PLActionButton(_ sender: UIButton) {
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!){
//        pickedImaged.image = image
//        self.dismiss(animated: true, completion: nil);
//    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!){
        if let tesseract = G8Tesseract(language: "eng") {
            tesseract.delegate = self
            tesseract.image = image?.g8_blackAndWhite()
            tesseract.recognize()
            
            //textView.text = tesseract.recognizedText
            stringController.append(tesseract.recognizedText)
            
            
            self.dismiss(animated: true, completion: nil);
            
        }
    }

}
