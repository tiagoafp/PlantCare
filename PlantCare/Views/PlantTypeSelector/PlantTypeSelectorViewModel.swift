import SwiftUI
import AtlasNetwork
import AtlasUI

@MainActor
protocol PlantTypeSelectorViewModelProtocol: ObservableObject {
    var fetchingMore: Bool { get }
    var search: String { get set }
    var path: NavigationPath { get set }
    var sheet: PlantTypeSelectorDestination? { get set }
    var state: PlantTypeSelectorViewModel.State { get }
    
    func onAppear() async
    func fetchMore() async
    func onSearch(search: String) async
    func onImage(image: AtlasImageUploadWrapperPickerResult) async
    func onItemSelector(item: PlantTypeAdapter)
}

final class PlantTypeSelectorViewModel: PlantTypeSelectorViewModelProtocol {
    var input: Input
    @Published var state: State
    @Published var path: NavigationPath
    @Published var sheet: PlantTypeSelectorDestination?
    @Published var search: String
    @Published var fetchingMore: Bool
    var nextPage: TrefleListResponse.PaginationLinks?
    var dataImage: Data?

    init(input: Input) {
        self.input = input
        self.state = .loading
        self.path = .init()
        self.sheet = nil
        self.search = ""
        self.fetchingMore = false
    }
    
    func onAppear() async {
        if search.isEmpty {
            await fetchList()
        } else {
            await onSearch(search: search)
        }
    }
    
    func fetchList() async {
        let result = await input.trefleAPI.getPlantsList(link: nil)

        switch result {
        case .success(let response):
            let responseList: [PlantTypeAdapter] = response.data.map { .init(data: $0) }
            
            self.nextPage = response.links
            self.state = .data(responseList)
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func fetchMore() async {
        if !search.isEmpty {
            await fetchingMoreOnSearch(search: search)
            return
        }
        
        if fetchingMore {
            return
        }
        
        self.fetchingMore = true
        
        guard let next = nextPage?.next else { return }
        
        let result = await input.trefleAPI.getPlantsList(link: next)
        
        switch result {
        case .success(let response):
            let responseList: [PlantTypeAdapter] = response.data.map { .init(data: $0) }
            
            if case .data(let list) = state {
                var newList = list
                newList.append(contentsOf: responseList)
                
                self.nextPage = response.links
                self.state = .data(newList)
                self.fetchingMore = false
            } else {
                state = .data(responseList)
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func onSearch(search: String) async {
        if search.isEmpty {
            await onAppear()
            return
        }
        
        let result = await input.trefleAPI.searchPlantsList(search: search, link: nil)

        switch result {
        case .success(let data):
            let list = data.data
            
            self.nextPage = data.links
            state = .searching(list.map { .init(data: $0) })
            
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func fetchingMoreOnSearch(search: String) async {
        if fetchingMore {
            return
        }
        
        self.fetchingMore = true
        
        guard let next = nextPage?.next else { return }
        
        let result = await input.trefleAPI.searchPlantsList(search: search, link: next)
        
        switch result {
        case .success(let response):
            let responseList: [PlantTypeAdapter] = response.data.map { .init(data: $0) }
            
            if case .searching(let list) = state {
                var newList = list
                newList.append(contentsOf: responseList)
                
                self.nextPage = response.links
                self.state = .searching(newList)
                self.fetchingMore = false
            } else {
                state = .searching(responseList)
            }
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
    
    func onImage(image: AtlasImageUploadWrapperPickerResult) async {
        guard case .data(let array) = state else {
            return
        }

        if case .image(let uIImage) = image {
            self.state = .recoginizingImage(array)
            self.dataImage = uIImage.jpegData(compressionQuality: 1)
            
            let response = await input.plantnetAPI.identify(image: uIImage)
            
            switch response {
            case .success(let success):
                self.state = .data(array)
                if let result = success.results.first?.species.scientificNameWithoutAuthor {
                    self.search = result
                }
            case .failure(let failure):
                self.state = .data(array)
                print(failure)
            }
        }
    }
    
    func onItemSelector(item: PlantTypeAdapter) {
        self.path.append(
            PlantTypeSelectorDestination.add(dataImage, item.data)
        )
    }
}

extension PlantTypeSelectorViewModel {
    struct Input: Sendable {
        var trefleAPI: any TrefleAPIProtocol
        var plantnetAPI: any PlantnetAPIProtocol
    }

    enum State {
        case loading
        case data([PlantTypeAdapter])
        case recoginizingImage([PlantTypeAdapter])
        case searching([PlantTypeAdapter])
    }
}
