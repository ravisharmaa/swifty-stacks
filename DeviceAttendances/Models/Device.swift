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


