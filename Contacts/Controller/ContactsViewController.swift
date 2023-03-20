//
//  ViewController.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 28/02/2023.
//

import UIKit
// protocol for using delegate design pattern
protocol AddContactProtocol {
    func contactInfo(firstName: String, lastName: String, number: String,image: Data?)
}

class ContactsViewController: UIViewController {
    
    @IBOutlet var emptySearchLabel: UILabel!
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
    
    @IBAction func SearchButtonPressed(_ sender: UIButton) {
        let searchKey = searchTextField.text
        fetchContacts(searchKey: searchKey)
    }
    
    // MARK: - fetching contacts
    func fetchContacts(searchKey: String? = nil) {
        do {
            let request = Contact.fetchRequest()
            let sort = NSSortDescriptor(key: #keyPath(Contact.fullName), ascending: true)
            request.sortDescriptors = [sort]
            if searchKey != nil && searchKey != "" {
                let predicate = NSPredicate(format: "fullName CONTAINS [c] '\(searchKey!)'")
                let predicate1 = NSPredicate(format: "number CONTAINS [c] '\(searchKey!)'")
                request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [predicate, predicate1])
            }
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

        if let vc = storyboard?.instantiateViewController(withIdentifier: "addContact") as? AddContactViewController {
            vc.contactDelegat = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contacts?.count == 0 {
            emptySearchLabel.isHidden = false
        } else {
            emptySearchLabel.isHidden = true
        }
       return contacts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactTableViewCell.identifier, for: indexPath) as! ContactTableViewCell
        cell.configure(model: contacts![indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellHeight = view.frame.size.height * 0.13
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contactsTableView.cellForRow(at: indexPath)?.isSelected = false
        // MARK: - update contact
        var contact = self.contacts![indexPath.row]
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "addContact") as? AddContactViewController {
            vc.contact = contact
            vc.updatedContactClosure = { Updatedcontact in
                contact = Updatedcontact
                do {
                    try self.context.save()
                } catch {
                    print("Eroor updating contact!")
                }
                DispatchQueue.main.async {
                    self.fetchContacts()
                }
            }
            navigationController?.pushViewController(vc, animated: true)
        }
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
// MARK: - conforming to delegate disign pattern protocol
extension ContactsViewController: AddContactProtocol{
    func contactInfo(firstName: String, lastName: String, number: String, image: Data?) {
        let newContact = Contact(context: self.context)
        newContact.firstName = firstName
        newContact.lastName = lastName
        newContact.fullName = "\(firstName) \(lastName)"
        newContact.number = number
        newContact.image = image
        
        do {
            try self.context.save()
        } catch {
            print("Eroor saving new contact!")
        }
        self.fetchContacts()
    }
}
