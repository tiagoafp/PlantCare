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
    
    func onAppear()
    func isSelected(type: PlantType) -> Bool
    func onDeleteType(type: PlantType)
    func onSelectType(type: PlantType)
    func onEditDone(type: PlantType)
    
    func onToolbar()
    func onDone()
    func onSave()
    func addNewPlant()
    
    func isTheLast(type: PlantType) -> Bool
}

class TypeListViewModel: TypeListViewModelProtocol {
    @Published var types: [PlantType] = []
    @Published var mode: TypeListMode
    @Published var editing: PlantType?
    
    let input: Input
    
    init(input: Input) {
        self.input = input
        self.mode = input.mode
    }
    
    func onAppear() {
        reloadTypes()
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
    
    func onSelectType(type: PlantType) {
        switch mode {
        case .selection(let plant):
            plant.type = type
        default:
            break
        }
    }
    
    func isSelected(type: PlantType) -> Bool {
        switch mode {
        case .selection(let plant):
            return plant.type == type
        default:
            return false
        }
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
            self.mode = input.mode
        } catch {}
    }
}

extension TypeListViewModel {
    public struct Input {
        let mode: TypeListMode
        let navigation: TypeListNavigationProtocol
        let repo: PlantTypeRepositoryProtocol
    }
}
