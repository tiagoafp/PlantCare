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
            
            ScrollView {
                GrouppedSectionView(nil) {
                    ForEach($viewModel.types) { $item in
                        switch viewModel.mode {
                        case .edit:
                            editCell(item: $item)
                        case .normal:
                            DisplayCell(
                                .labels(.title(item.name)),
                                disclosure: false,
                                separator: !viewModel.isTheLast(type: item)
                            )
                        case .selection:
                            SelectableCell(
                                text: item.name,
                                isSelected: viewModel.isSelected(type: item),
                                separator: !viewModel.isTheLast(type: item),
                                onSelect: {
                                    viewModel.onSelectType(type: item)
                                }
                            )
                        }
                    }
                }
                .padding(.top, 16)
            }
            .onTapGesture {
                viewModel.addNewPlant()
            }
            if viewModel.mode == .edit {
                FooterActionView([
                    .init(
                        title: .translation(.save),
                        action: {
                            viewModel.onSave()
                        })
                ])
            }
        }
        .background(
            Rectangle()
                .foregroundStyle(PixelKit.shared.theme.background)
        )
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: viewModel.onToolbar) {
                    Text(toolbarModeString(mode: viewModel.mode))
                }
            }
        }
        .task {
            viewModel.onAppear()
        }
        .navigationTitle(.translation(.types))
        .ignoresSafeArea(edges: .bottom)
    }
    
    func toolbarModeString(mode: TypeListMode) -> String {
        switch mode {
        case .normal, .selection:
            return .translation(.edit)
        case .edit:
            return .translation(.add)
        }
    }
}

extension TypeListView {
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
