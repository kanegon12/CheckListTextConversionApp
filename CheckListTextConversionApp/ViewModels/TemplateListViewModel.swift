//
//  TemplateListViewModel.swift
//  CheckListTextConversionApp
//
//  Created by 金子朝紀 on 2026/05/02.
//

import SwiftUI
import SwiftData

@Observable // 変数が変わったら自動でViewを更新してくれる
class TemplateListViewModel{
    
    // 編集シートの表示状態　開いてるか？
    var showEditView: Bool = false
    // 編集対象のテンプレート　(nilなら新規作成)
    var editingTemplate: Template? = nil
    // 削除確認用アラート表示状態　アラートが出ているかどうか
    var showDeleteAlert: Bool = false
    // 削除対象のテンプレートはどれか？
    var deletingTemplate: Template? = nil
    
    // 削除ボタンが押された時
    func onDeleteButtonTapped(template: Template) {
        // 「これを削除しようとしている」と記憶
        deletingTemplate = template
        showDeleteAlert = true
    }
    
    // 編集ボタンが押された時
    func onEditButtonTapped(template: Template) {
        // 「このテンプレートを編集する」と記憶
        editingTemplate = template
        // シートを開く
        showEditView = true
    }
    
    // 新規作成ボタンが押された時
    func onAddButtonTapped() {
        // 新規作成なので「編集中のテンプレートなし」
        editingTemplate = nil
        // シートを開く
        showEditView = true
    }
    
    // 削除を実行する
    func deleteTemplate(modelContext: ModelContext) {
        // nilではない場合のみ処理を続行
        guard let template = deletingTemplate else { return }
        // DBから削除
        modelContext.delete(template)
        // 削除対象リセット
        deletingTemplate = nil
    }
    
    // 編集モードでの削除
    func deleteTemplates(at offsets: IndexSet, templates: [Template], modelContext: ModelContext) {
        // IndexSetで複数選択でも削除できる
        for index in offsets {
            modelContext.delete(templates[index])
        }
    }
    
    // 編集モードでの並び替え
    func moveTemplates(from source: IndexSet, to destination: Int, templates: [Template]) {
        var reordered = templates.sorted { $0.templateCreatedAt < $1.templateCreatedAt }
        reordered.move(fromOffsets: source, toOffset: destination)
        for (index, template) in reordered.enumerated() {
            template.templateCreatedAt = Date(timeIntervalSinceReferenceDate: Double(index))
        }
    }
    
    // サブタイトルテキストを生成
    func subtitleText(for template: Template) -> String {
        let sectionCount = template.sections.count
        // flatMapで入れ子の配列を1つの配列に押しつぶす
        let itemCount = template.sections.flatMap(\.items).count
        return "\(sectionCount)セクション\(itemCount)項目"
    }

}
