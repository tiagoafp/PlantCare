//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by tiago.pereira on ___DATE___.
//

import SwiftUI

protocol ___FILEBASENAME___Protocol: ObservableObject {}

class ___FILEBASENAME___: ___FILEBASENAME___Protocol {
    let input: Input
    
    init (input: Input) {
        self.input = input
    }
}

extension ___FILEBASENAME___ {
    public struct Input {
        let navigation: ___VARIABLE_productName:identifier___NavigationProtocol
    }
}
