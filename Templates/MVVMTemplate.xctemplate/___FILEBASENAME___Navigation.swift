//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by tiago.pereira on ___DATE___.
//

import SwiftUI

protocol ___FILEBASENAME___Protocol {}

class ___FILEBASENAME___: ___FILEBASENAME___Protocol {
    var navPath: Binding<NavigationPath>
    
    init(navPath: Binding<NavigationPath>) {
        self.navPath = navPath
    }
}


extension ___FILEBASENAME___ {
    enum Destinations: Hashable {
    }
}
