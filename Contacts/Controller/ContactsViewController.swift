//
//  ViewController.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 28/02/2023.
//

import UIKit

class ContactsViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var contacts: [Contact]?
    
    @IBOutlet var searchTextField: CustomTextField!
    @IBOutlet var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addContact))
        contactsTableView.register(ContactTableViewCell.nib(), forCellReuseIdentifier: ContactTableViewCell.identifier)
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
        fetchContacts()
    }
    
    // MARK: - fetching contacts
    func fetchContacts() {
        do {
            let request = Contact.fetchRequest()
            self.contacts = try context.fetch(request)
            DispatchQueue.main.async {
                self.contactsTableView.reloadData()
            }
        } catch {
            print("Error fetching contacts!")
        }
    }
    
    // MARK: - add contact
    @objc func addContact() {
        let alert = UIAlertController(title: "add Contact", message: "", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.textFields![0].placeholder = "First Name"
        alert.textFields![1].placeholder = "Last Name"
        alert.textFields![2].placeholder = "Number"
        
        let addAction = UIAlertAction(title: "Add", style: .default) { action in
            let newContact = Contact(context: self.context)
            newContact.firstName = alert.textFields![0].text
            newContact.lastName = alert.textFields![1].text
            newContact.number = alert.textFields![2].text
            
            do {
                try self.context.save()
            } catch {
                print("Eroor saving new contact!")
            }
            self.fetchContacts()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    @IBAction func SearchButtonPressed(_ sender: UIButton) {
        
    }
    
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        cell.configure(model: contacts![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contactsTableView.cellForRow(at: indexPath)?.isSelected = false
        
        let contact = self.contacts![indexPath.row]
        
        let alert = UIAlertController(title: "Update Contact", message: "", preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.textFields![0].placeholder = "First Name"
        alert.textFields![1].placeholder = "Last Name"
        alert.textFields![2].placeholder = "Number"
        alert.textFields![0].text = contact.firstName
        alert.textFields![1].text = contact.lastName
        alert.textFields![2].text = contact.number
        
        let addAction = UIAlertAction(title: "Update", style: .default) { action in
            contact.firstName = alert.textFields![0].text
            contact.lastName = alert.textFields![1].text
            contact.number = alert.textFields![2].text
            do {
                try self.context.save()
            } catch {
                print("Eroor updating contact!")
            }
            self.fetchContacts()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // MARK: - delete contact
        let action = UIContextualAction(style: .destructive, title: "Delete") { (actoin, view, completionHandler) in
            let contactToRemove = self.contacts![indexPath.row]
            self.context.delete(contactToRemove)
            do {
                try self.context.save()
            } catch {
                print("Can't delete person!")
            }
            self.fetchContacts()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
}

