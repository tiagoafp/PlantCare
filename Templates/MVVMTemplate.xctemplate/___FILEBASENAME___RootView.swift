//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by tiago.pereira on ___DATE___.
//

import SwiftUI

public struct ___FILEBASENAME___: View {
    let navigation: ___VARIABLE_productName:identifier___NavigationProtocol
    
    init(navigationPath: Binding<NavigationPath>) {
        navigation = ___VARIABLE_productName:identifier___Navigation(navPath: navigationPath)
    }
    
    public var body: some View {
        ___VARIABLE_productName:identifier___View(
            viewModel: ___VARIABLE_productName:identifier___ViewModel(
                input: .init(
                    navigation: navigation
                )
            )
        )
        .navigationDestination(
            for: ___VARIABLE_productName:identifier___Navigation.Destinations.self,
            destination: navigateTo
        )
    }
}

extension ___FILEBASENAME___ {
    @ViewBuilder
    func navigateTo(destination: ___VARIABLE_productName:identifier___Navigation.Destinations) -> some View {
        EmptyView()
    }
}
