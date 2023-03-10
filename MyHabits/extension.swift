//
//  extension.swift
//  MyHabits
//
//  Created by Александр Хмыров on 10.03.2023.
//

import UIKit

extension UIColor {

    static func createColorForTheme(lightTheme: UIColor, darkTheme: UIColor) -> UIColor {

        guard #available(iOS 13.0, *) else {
            return lightTheme
        }

        return UIColor { uiTraitCollection in

            return uiTraitCollection.userInterfaceStyle == .dark ? darkTheme : lightTheme
        }



    }
}



