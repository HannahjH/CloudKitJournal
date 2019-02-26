//
//  EntryDetailViewController.swift
//  CloudKitJournal
//
//  Created by Hannah Hoff on 2/25/19.
//  Copyright © 2019 Hannah Hoff. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry : Entry? {
        didSet {
            loadViewIfNeeded()
            updateView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        titleTextField.text = entry?.title
        bodyTextView.text = entry?.body
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let title = titleTextField.text,
            let body = bodyTextView.text else { return }
        if let entry = entry {
            
            EntryController.shared.updateEntry(entry: entry, title: title, body: body) { (success) in
                if success {
                    print("Success updating entry")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("Failure updating entry")
                }
            }
        } else {
            
            EntryController.shared.addEntryWith(title: title, body: body) { (success) in
                if success {
                    print("Success in creating new entry")
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("Failure creating new entry")
                }
            }
        }
    }
}
