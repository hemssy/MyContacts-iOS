import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    let tableView = UITableView()

    // 코어데이터에서 가져온 데이터가 여기에 담김
    private var contacts: [ContactEntity] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "친구 목록"

        let addButton = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = addButton

        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchContacts()

        contacts.sort {
            ($0.name ?? "") < ($1.name ?? "")
        }
        
        tableView.reloadData()
    }

    @objc func addTapped() {
        let vc = PhoneBookViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func fetchContacts() {
        let request: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()

        do {
            contacts = try CoreDataStack.context.fetch(request)
        } catch {
            print("fetch error:", error)
            contacts = []
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactCell
        cell.configure(with: contacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        let vc = PhoneBookViewController()
        vc.existingContact = contact
        navigationController?.pushViewController(vc, animated: true)
    }
}

