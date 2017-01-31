//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Sridhar Ramaswamy on 1/26/17.
//  Copyright © 2017 Sridhar Ramaswamy. All rights reserved.
//

import UIKit
import os.log


class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate,
    UIGestureRecognizerDelegate {
    
    //MARK: properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /*
     This value is either passed by `MealTableViewController` in `prepare(for:sender:)`
     or constructed as part of adding a new meal.
     */
    var meal: Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.delegate = self
        
        // let tapGR = UITapGestureRecognizer(target: ratingControl, action: #selector(RatingControl.doubleTap(_:)))
        // tapGR.numberOfTapsRequired = 2
        // ratingControl.addGestureRecognizer(tapGR)

        let tapGR = UITapGestureRecognizer(target: self, action: #selector(MealViewController.doubleTap(_:)))
        tapGR.numberOfTapsRequired = 2
        ratingControl.addGestureRecognizer(tapGR)

        updateSaveButtonState()
    }
    
    
    //MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // disable save button
        saveButton.isEnabled = false
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    
    
    //MARK: Navigation
    
    func doubleTap(_ sender: UITapGestureRecognizer) {
        ratingControl.rating = 5
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default,
                   type: .debug)
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        // create meal to be passed to `MealTableViewController`
        meal = Meal(name: name, photo: photo, rating: rating)
        
    }
    
    //MARK: Actions
    
    @IBAction func imageDoubleTap(_ sender: UITapGestureRecognizer){
        print("double tapped on image selector, eh?")
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard
        nameTextField.resignFirstResponder()
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // only allow photos to be picked, not taken
        // imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        // Make sure viewcontroller is notified when the user picks an image
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    

    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // The info dictionary may contain multiple representations of the image. You want to use the original
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
        UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided \(info)")
        }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

