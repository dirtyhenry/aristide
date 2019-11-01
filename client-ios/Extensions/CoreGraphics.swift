import CoreGraphics

extension CGRect {
    var area: CGFloat {
        return size.area
    }
}

extension CGSize {
    var area: CGFloat {
        return width * height
    }
}
