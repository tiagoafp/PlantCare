//
//  TypeListViewModel.swift
//  PlantCare
//
//  Created by tiago.pereira on 8/6/25.
//

import SwiftUI

@MainActor
protocol TypeListViewModelProtocol: ObservableObject {
    var types: [PlantType] { get set }
    var editing: PlantType? { get set }
    var mode: TypeListMode { get }
    
    func isSelected(type: PlantType) -> Bool
    func onDeleteType(type: PlantType)
    func onSelectType(type: PlantType)
    func onEditDone(type: PlantType)
    
    func reloadTypes()
    func onToolbar()
    func onDone()
    func onSave()
    func addNewPlant()
    
    func isTheLast(type: PlantType) -> Bool
}

class TypeListViewModel: ViewModelRouter<TypeListRoute>, TypeListViewModelProtocol {
    @Published var types: [PlantType] = []
    @Published var mode: TypeListMode
    @Published var editing: PlantType?
    @Published var selected: Binding<PlantType?>
    
    let input: Input
    
    init(input: Input) {
        self.input = input
        self.selected = input.selected
        self.mode = input.selected.wrappedValue != nil ? .selection : .normal
    }
    
    func reloadTypes() {
        if let types = try? input.repo.fetchTypes() {
            self.types = types
        }
    }
    
    func isTheLast(type: PlantType) -> Bool {
        type == types.last
    }
    
    func onEditDone(type: PlantType) {
        if type.name.isEmpty {
            input.repo.delete(type: type)
            reloadTypes()
        }
    }
    func addNewPlant() {
        if mode != .edit { return }
        let newType = PlantType(name: "")
        self.editing = newType
        
        input.repo.insert(type: newType)
        reloadTypes()
    }
    
    func onToolbar() {
        switch mode {
        case .normal, .selection:
            mode = .edit
        case .edit:
            addNewPlant()
        }
        self.mode = .edit
    }
    
    
    func onDeleteType(type: PlantType) {
        switch mode {
        case .edit:
            if type.plants.isEmpty {
                input.repo.delete(type: type)
                reloadTypes()
            }
        default:
            break
        }
    }
    
    func isSelected(type: PlantType) -> Bool {
        type == selected.wrappedValue
    }
    
    func onSelectType(type: PlantType) {
        selected.wrappedValue = type
    }
    
    func onDone() {
        do {
            try self.input.repo.save()
            self.mode = .normal
        } catch {}
        
    }
    
    func onSave() {
        do {
            self.editing = nil
            try self.input.repo.save()
            self.mode = .normal
        } catch {}
    }
}

extension TypeListViewModel {
    public struct Input {
        let repo: PlantTypeRepositoryProtocol
        let selected: Binding<PlantType?>
    }
}
