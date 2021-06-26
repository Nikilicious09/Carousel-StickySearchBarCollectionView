//
//  HPModel.swift
//  AssesmentProject
//
//  Created by Nikil Vinod on 26/06/21.
//

import Foundation
struct HPModel : Codable {
    let name : String?
    let image : String?
    var isCarousalItem : Bool = false

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case image = "image"
        case isCarousalItem = "isCarousalItem"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isCarousalItem = try values.decodeIfPresent(Bool.self, forKey: .isCarousalItem) ?? false
    }

}
