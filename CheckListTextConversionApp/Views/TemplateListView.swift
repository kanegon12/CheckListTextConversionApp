//
//  TemplateListView.swift
//  CheckListTextConversionApp
//
//  Created by 金子朝紀 on 2026/05/04.
//

import SwiftUI
import SwiftData

struct TemplateListView: View {
    
    // MARK: - Properties
    
    // @Queryでデータが増減したら自動でView更新
    @Query(sort: \Template.templateCreatedAt)
    private var templates: [Template]
    
    @Environment(\.modelContext)
    private var modelContext
    
    @Environment(\.editMode)
    private var editMode
    
    //ViewModelのインスタンスをStateで保持
    @State private var viewModel = TemplateListViewModel()
    
    // MARK: - Body
    
    var body: some View {
        NavigationStack {
            Group {
                if templates.isEmpty {
                    emptyView
                } else {
                    templateList
                }
            }
            .navigationTitle("テンプレート一覧")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.onAddButtonTapped()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if !templates.isEmpty {
                        EditButton()
                            .environment(\.locale, Locale(identifier: "ja_JP"))
                    }
                }
            }
            .sheet(isPresented: $viewModel.showEditView) {
                // AdBannerContatinerができたら入れる
            }
            .alert("テンプレートを削除しますか？", isPresented: $viewModel.showDeleteAlert) {
                Button("削除", role: .destructive) {
                    viewModel.deleteTemplate(modelContext: modelContext)
                }
                Button("キャンセル", role: .cancel) {
                    viewModel.deletingTemplate = nil
                }
            } message: {
                if let name = viewModel.deletingTemplate?.templateName {
                    Text("「\(name)」を削除します。この操作は元に戻せません。")
                }
            }
            
        }
    }
    
    // MARK: - View Components
    
    private var emptyView: some View {
        ContentUnavailableView("テンプレートがありません", systemImage: "list.bullet.clipboard", description: Text("右上の＋ボタンからテンプレートを作成してください！"))
    }
    
    private var templateList: some View {
        List {
            ForEach(templates) { template in
                if editMode?.wrappedValue == .active {
                    // 編集モード中：タップ → 編集シートが開く
                    Button {
                        viewModel.onEditButtonTapped(template: template)
                    } label: {
                        templateRow(template: template)
                    }
                } else {
                    // 通常モード：タップ → チェック画面に遷移
                    NavigationLink {
                        /// CheckViewができたら差し替え
                        Text("チェック画面(準備中)")
                    } label: {
                        templateRow(template: template)
                    }
                    // スワイプで削除・編集
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        deleteButton(template: template)
                        editButton(template: template)
                    }
                }
            }
            .onDelete { offsets in
                viewModel.deleteTemplates(
                    at: offsets,
                    templates: templates,
                    modelContext: modelContext
                )
            }
            .onMove { from, to in
                viewModel.moveTemplates(
                    from: from,
                    to: to,
                    templates: templates
                )
            }
        }
    }
    
    private func templateRow(template: Template) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(template.templateName)
                .font(.body)
            Text(viewModel.subtitleText(for: template))
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
    
    private func editButton(template: Template) -> some View{
        Button {
            viewModel.onEditButtonTapped(template: template)
        } label: {
            Label("編集", systemImage: "pencill")
        }
        .tint(.orange)
    }
    
    private func deleteButton(template: Template) -> some View {
        Button {
            viewModel.onEditButtonTapped(template: template)
        } label: {
            Label("削除", systemImage: "trash")
        }
    }
}

#Preview {
    TemplateListView()
        .modelContainer(for: Template.self,inMemory: true)
}
