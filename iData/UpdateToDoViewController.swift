//
//  UpdateToDoViewController.swift
//  iData
//
//  Created by Sushil Dahal on 4/18/16.
//  Copyright © 2016 Sushil Dahal. All rights reserved.
//

import UIKit
import CoreData

class UpdateToDoViewController: UIViewController {
    @IBOutlet weak var itemTextField: UITextField!
    
    var record: NSManagedObject!
    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let name = record.valueForKey("name") as? String {
            itemTextField.text = name
        }
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

    @IBAction func cancel(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        let name = itemTextField.text
        
        if let isEmpty = name?.isEmpty where isEmpty == false {
            // Update Record
            record.setValue(name, forKey: "name")
            
            do {
                // Save Record
                try record.managedObjectContext?.save()
                
                // Dismiss View Controller
                navigationController?.popViewControllerAnimated(true)
                
            } catch {
                let saveError = error as NSError
                print("\(saveError), \(saveError.userInfo)")
                
                // Show Alert View
                showAlertWithTitle("Warning", message: "Your to-do could not be saved.", cancelButtonTitle: "OK")
            }
            
        } else {
            // Show Alert View
            showAlertWithTitle("Warning", message: "Your to-do needs a name.", cancelButtonTitle: "OK")
        }
    }
    
    // MARK: -
    // MARK: Helper Methods
    private func showAlertWithTitle(title: String, message: String, cancelButtonTitle: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // Configure Alert Controller
        alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .Default, handler: nil))
        
        // Present Alert Controller
        presentViewController(alertController, animated: true, completion: nil)
    }
}
