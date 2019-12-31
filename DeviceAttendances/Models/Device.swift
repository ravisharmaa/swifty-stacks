import Foundation


struct Device: Codable {
    var results: [Results]
}

struct Results: Codable {
    var assigned_date: String
    var assignee: String
    var item_name: String
    var item_serial: String
    var status: String
}


extension Results {
    
    static func all(email: String, from url: String) -> [Results]? {
        
        var results:[Results] = [Results]()
        
        guard let url = URL(string: url + email) else { return nil }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let jsonData = data else { return }
            
            do {
                let devices = try JSONDecoder().decode(Device.self, from: jsonData)
                results = devices.results
            } catch let jsonError {
                print("Could not parse json \(jsonError)")
            }
        }.resume()
        
        return results
    }
}
