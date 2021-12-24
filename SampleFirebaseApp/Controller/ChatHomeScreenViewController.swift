//
//  ChatHomeScreenViewController.swift
//  SampleFirebaseApp
//
//  Created by matthew savidge on 12/22/21.
//

import Foundation
import UIKit
import Firebase

class ChatHomeScreenViewController: UIViewController{
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        contactsTableView.dataSource = self
        /// use in possible future use
        //contactsTableView.delegate = self
        loadMessages()
    }
    
    func loadMessages(){
        db.collection(MessageModel.Fstore.collectionName).order(by: MessageModel.Fstore.dateField).addSnapshotListener { queryShapShot, error in
            self.messages = []
            if let e = error{
                print(e)
            }else{
                if let snapshotDocuments = queryShapShot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let sender = data[MessageModel.Fstore.senderField] as? String, let messageBody = data[MessageModel.Fstore.bodyField] as? String{
                            let newMessage = MessageModel(sender: sender, body: messageBody)
                            self.messages.append(newMessage)
                            DispatchQueue.main.async{
                                self.contactsTableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    var messages: [MessageModel] = []
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBAction func sendMessageButtonPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection(MessageModel.Fstore.collectionName).addDocument(data: [MessageModel.Fstore.senderField: messageSender, MessageModel.Fstore.bodyField: messageBody, MessageModel.Fstore.dateField: Date().timeIntervalSince1970]) { error in
                if let e = error{
                    print(e)
                }else{
                    print("data saved")
                }
            }
        }
        messageTextField.text = ""
    }
}
    extension ChatHomeScreenViewController: UITableViewDataSource{
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = contactsTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
            cell.textLabel?.text = messages[indexPath.row].sender
            cell.detailTextLabel?.text = messages[indexPath.row].body
            return cell
        }
    }
    /// use in possible future use
    //extension ChatHomeScreenViewController: UITableViewDelegate{
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        <#code#>
    //    }
    //}

