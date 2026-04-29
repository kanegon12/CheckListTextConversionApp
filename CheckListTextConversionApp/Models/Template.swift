//
//  Template.swift
//  CheckListTextConversionApp
//
//  Created by 金子朝紀 on 2026/04/30.
//

import Foundation
import SwiftData

@Model // このclassはデータベースに保存するデータだ」と伝える目印
final class Template {
    // テンプレートの一意なID(他と被らない)
    var templateId: String
    // テンプレートの名前
    var templateName: String
    // 作成日。 Date型　日時を表す型
    var templateCreatedAt: Date
    @Relationship(deleteRule: .cascade, inverse: \TemplateSection.template)
    var section: TemplateSection
    
    init(name: String) {
        self.templateId = UUID().uuidString
        self.templateName = name
        self.templateCreatedAt = Date()
        self.section = []
    }
    
}
