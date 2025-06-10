//
//  CodableDecodable.swift
//  monkeyescape
//
//  Created by Matthew Fang on 6/7/25.
//

import Observation
import SwiftUI

struct CustomerModel: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case points
//        case isPremium
//    }
//    
//    init(id: String, name: String, points: Int, isPremium: Bool) {
//        self.id = id
//        self.name = name
//        self.points = points
//        self.isPremium = isPremium
//    }
//    
//    init(from decoder: Decoder) throws {
//        // TODO: learn the whole type.self thing
//        // TODO: learn enum
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.points = try container.decode(Int.self, forKey: .points)
//        self.isPremium = try container.decode(Bool.self, forKey: .isPremium)
//    }
}

@Observable class CodableViewModel {
    var customer: CustomerModel? = CustomerModel(id: "1", name: "Monkey", points: 5, isPremium: true)

    // TODO: MVVM WHY INIT?
    init() {
        getData()
    }

    func getData() {
        guard let data = getJSONData() else { return }
        
//        let self.customer = data.decode(type: CustomerModel.self, decoder: JSONDecoder())
//
//        let self.customer = try? JSONDecoder().decode(CustomerModel.self, from: data)
        
//        do {
//            self.customer = try JSONDecoder().decode(CustomerModel.self, from: data)
//        } catch let error {
//            print("error decoding \(error)")
//        }

//        if
//            let localData = try? JSONSerialization.jsonObject(with: data),
//
//            // MARK: `as` lets you convert between two RELATED types - not value conversion - the two types are inherently related
//
//            let dictionary = localData as? [String: Any],
//            let id = dictionary["id"] as? String,
//            let name = dictionary["name"] as? String,
//            let points = dictionary["points"] as? Int,
//            let isPremium = dictionary["isPremium"] as? Bool
//        {
//            let newCustomer = CustomerModel(id: id, name: name, points: points, isPremium: isPremium)
//            customer = newCustomer
//        }

//        print("JSON DATA:")
//        print(data)
//        let jsonString = String(data: data, encoding: .utf8)
//        print(jsonString)
    }
    
    // TODO: LEARN ERROR HANDLING VS OPTIONAL HANDLING
    func getJSONData() -> Data? {
        let fakeDictionary: [String: Any] = [
            "id": "12345",
            "name": "Matthew",
            "points": 3,
            "isPremium": true
        ]

        let jsonData = try? JSONSerialization.data(withJSONObject: fakeDictionary)
        return jsonData
    }
}

struct CodableDecodable: View {
    @State var viewModel = CodableViewModel()

    var body: some View {
        List {
            if let customer = viewModel.customer {
                Text("#\(customer.id): \(customer.name) has \(customer.points) points")
                    .background(customer.isPremium ? .yellow : .clear)
            }
        }
    }
}

#Preview {
    CodableDecodable()
}
