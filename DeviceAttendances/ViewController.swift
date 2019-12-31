import UIKit

class ViewController: UIViewController {
    
    var results: [Results] = [Results]()
    
    var emailField: String?
    
    //let url: String = "http://10.0.1.8/datasets.php?email="
    
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    lazy var deviceListTableView: UITableView = {
        
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
        
    }()
    
    var filteredResults: [Results] = []
    
    var isSearchEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        self.title = "Devices"
        
        view.backgroundColor = .white
        
        // set up for search controller
        
        //searchController.searchResultsUpdater = self
        
        searchController.searchBar.placeholder = "Search Devices"
        
        navigationItem.searchController = searchController
        
        definesPresentationContext = true
        
        
        
        // set up view
        view.addSubview(deviceListTableView)
        
        setupConstraintsForTable()
        
        //self.results = Results.all(email: emailField!, from: self.url)!
        
        getDataFromUrl(emailField!)
    }
    
    fileprivate func getDataFromUrl(_ forEmail: String) {
        
        
        guard let url = URL(string: "http://10.0.1.8/datasets.php?email=" + "\(forEmail)") else { return  }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let jsonData = data else { return }
            
            do {
                let devices = try JSONDecoder().decode(Device.self, from: jsonData)
                self.results = devices.results
                DispatchQueue.main.async { [weak self ] in
                    self?.deviceListTableView.reloadData()
                }
            } catch let jsonError {
                print("Could not parse json \(jsonError)")
            }
            }.resume()
    }
    
    func setupConstraintsForTable() {
        
        NSLayoutConstraint.activate([
            deviceListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            deviceListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            deviceListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            deviceListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
            ])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellId")
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        }
        
        cell?.textLabel?.text = results[indexPath.row].item_name
        cell?.detailTextLabel?.text = "Assigned Date: " + results[indexPath.row].assigned_date
        
        return cell!
    }
    
    
}


//extension ViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        <#code#>
//    }
//
//
//}
//
