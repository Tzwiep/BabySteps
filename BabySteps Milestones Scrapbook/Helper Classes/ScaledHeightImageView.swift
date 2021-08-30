//
//  ScaledHeightImageView.swift
//  BabySteps
//
//  Created by Tyler Zwiep on 2021-07-20.
//

/* this class resolves the issue of aspect fill leaving space between imageView and the label,
 by scaling the image and maintaining the aspect ratio. This class was created based on information found at:
 https://stackoverflow.com/questions/41154784/how-to-resize-uiimageview-based-on-uiimages-size-ratio-in-swift-3
*/

import Foundation
import UIKit

class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {

        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
 
            let ratio = myViewWidth/myImageWidth
            let scaledHeight = myImageHeight * ratio

            return CGSize(width: myViewWidth, height: scaledHeight)
        }

        return CGSize(width: -1.0, height: -1.0)
    }

}
