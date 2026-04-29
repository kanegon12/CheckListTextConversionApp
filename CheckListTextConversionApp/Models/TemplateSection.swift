//
//  TemplateSection.swift
//  CheckListTextConversionApp
//
//  Created by 金子朝紀 on 2026/04/30.
//

import Foundation
import SwiftData

@Model
final class TemplateSection {
    var sectionId: String
    var sectionTitle: String
    var sectionOrder: Int
    var template: Template?
    @Relationship(deleteRule: .cascade, inverse: \CheckItem.section)
    var items: [CheckItem]
    
    init(title: String, order: Int) {
        self.sectionId = UUID().uuidString
        self.sectionTitle = title
        self.sectionOrder = order
        self.items = []
    }
}
