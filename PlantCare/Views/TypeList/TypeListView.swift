//
//  TypeListView.swift
//  PlantCare
//
//  Created by tiago.pereira on 8/6/25.
//

import SwiftUI
import PixelKit

struct TypeListView<ViewModel: TypeListViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .foregroundStyle(PixelKit.shared.theme.background)
                .onTapGesture {
                    viewModel.addNewPlant()
                }
            if $viewModel.types.isEmpty {
                Text("Empty list")
            } else {
                ScrollView {
                    GrouppedSectionView {
                        ForEach($viewModel.types) { $item in
                            switch viewModel.mode {
                            case .edit:
                                editCell(item: $item)
                            case .selection, .normal:
                                selectionCell(item: item)
                            }
                        }
                    }
                    .padding(.top, 16)
                }
            }
            if viewModel.mode == .edit {
                FooterActionView([
                    .init(
                        title: .localized(.save),
                        action: {
                            viewModel.onSave()
                        })
                ])
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: viewModel.onToolbar) {
                    Text(toolbarModeString(mode: viewModel.mode))
                }
            }
        }
        .navigationTitle(.localized(.types))
        .ignoresSafeArea(edges: .bottom)
        .task {
            viewModel.reloadTypes()
        }
    }
    
    func toolbarModeString(mode: TypeListMode) -> String {
        switch mode {
        case .normal, .selection:
            return .localized(.edit)
        case .edit:
            return .localized(.add)
        }
    }
}

extension TypeListView {
    @ViewBuilder
    func selectionCell(item: PlantType) -> some View {
        SelectableCell(
            text: item.name,
            isSelected: viewModel.isSelected(type: item),
            separator: !viewModel.isTheLast(type: item),
            onSelect: {
                viewModel.onSelectType(type: item)
            }
        )
    }
    
    @ViewBuilder
    func editCell(item: Binding<PlantType>) -> some View {
        EditableCell<PlantType>(
            text: item.name,
            separator: !viewModel.isTheLast(type: item.wrappedValue),
            selected: viewModel.editing,
            element: item.wrappedValue,
            onDelete: { viewModel.onDeleteType(type: item.wrappedValue) },
            onSelect: { viewModel.onSelectType(type: item.wrappedValue) },
            onDone: { viewModel.onEditDone(type: item.wrappedValue) }
        )
    }
}
