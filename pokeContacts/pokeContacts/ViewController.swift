import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource {
    

    let tableView = UITableView()
    

    let contacts: [Contact] = [
        Contact(name: "name", phone: "010-0000-0000"),
        Contact(name: "name", phone: "010-0000-0000"),
        Contact(name: "name", phone: "010-0000-0000"),
        Contact(name: "name", phone: "010-0000-0000"),
        Contact(name: "name", phone: "010-0000-0000"),
        Contact(name: "name", phone: "010-0000-0000")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        

        self.title = "친구 목록"
        

        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addButton
        

        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        
        view.addSubview(tableView)
        

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    

    @objc func addTapped() {
        let vc = PhoneBookViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        let contact = contacts[indexPath.row]
        cell.configure(name: contact.name, phone: contact.phone)
        return cell
    }
}

