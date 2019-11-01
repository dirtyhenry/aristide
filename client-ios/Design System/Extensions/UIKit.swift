import UIKit

// This file must only contain extensions related to the Design System.

struct Padding {
    let top: CGFloat?
    let bottom: CGFloat?
    let leading: CGFloat?
    let trailing: CGFloat?

    init(
        top: CGFloat? = nil,
        bottom: CGFloat? = nil,
        leading: CGFloat? = nil,
        trailing: CGFloat? = nil
    ) {
        self.top = top
        self.bottom = bottom
        self.leading = leading
        self.trailing = trailing
    }

    static let allZero = Padding(top: 0.0, bottom: 0.0, leading: 0.0, trailing: 0.0)
}

extension UIBarButtonItem {
    static func blank() -> UIBarButtonItem {
        return UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
    }
}

extension UIButton {
    var textStyle: Theme.TextStyle {
        get {
            fatalError("textStyle is designed to be used with a setter only")
        }
        set {
            setTitleColor(newValue.color.uiColor, for: .normal)
            titleLabel?.font = newValue.font
        }
    }
}

extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        }

        return image
    }

    func imageWith(newHeight: CGFloat) -> UIImage {
        let newSize = CGSize(width: newHeight * size.width / size.height, height: newHeight)
        return imageWith(newSize: newSize)
    }
}

extension UILabel {
    var textStyle: Theme.TextStyle {
        get {
            fatalError("textStyle is designed to be used with a setter only")
        }
        set {
            font = newValue.font
            textColor = newValue.color.uiColor
        }
    }
}

extension UITextField {
    var textStyle: Theme.TextStyle {
        get {
            fatalError("textStyle is designed to be used with a setter only")
        }
        set {
            font = newValue.font
            textColor = newValue.color.uiColor
        }
    }
}

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        for subview in subviews {
            addSubview(subview)
        }
    }

    static func viewForAutoLayout(_ subviews: [UIView] = []) -> UIView {
        let wrapper = UIView()
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addSubviews(subviews)
        return wrapper
    }

    func bindToSafeAreaOf(
        _ view: UIView,
        padding: Padding = .allZero
    ) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint?] = []

        constraints.append(
            padding.top.map { topPadding in
                topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: topPadding
                )
            }
        )
        constraints.append(
            padding.leading.map { leadingPadding in
                leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: leadingPadding
                )
            }
        )
        constraints.append(
            padding.bottom.map { bottomPadding in
                bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: bottomPadding
                )
            }
        )
        constraints.append(
            padding.trailing.map { trailingPadding in
                trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: trailingPadding
                )
            }
        )

        return constraints.compactMap { $0 }
    }

    func bindTo(
        _ view: UIView,
        padding: Padding = .allZero
    ) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint?] = []

        constraints.append(
            padding.top.map { topAnchor.constraint(equalTo: view.topAnchor, constant: $0) }
        )
        constraints.append(
            padding.leading.map { leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: $0) }
        )
        constraints.append(
            padding.bottom.map { bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: $0) }
        )
        constraints.append(
            padding.trailing.map { trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: $0) }
        )

        return constraints.compactMap { $0 }
    }

    func bindToXAxisOf(
        _ view: UIView,
        constant: CGFloat
    ) -> [NSLayoutConstraint] {
        return [
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant)
        ]
    }
}

#if DEBUG
    extension UIColor {
        static var random: UIColor {
            return .init(hue: .random(in: 0 ... 1), saturation: 0.5, brightness: 0.9, alpha: 1.0)
        }
    }

    extension UIView {
        func debugSubviews() {
            subviews.forEach { subview in
                subview.backgroundColor = .random
                layer.borderColor = UIColor.random.cgColor
                layer.borderWidth = 1.0
                subview.debugSubviews()
            }
        }
    }
#endif

func + (lhs: [NSLayoutConstraint], rhs: NSLayoutConstraint) -> [NSLayoutConstraint] {
    return lhs + [rhs]
}

func + (lhs: NSLayoutConstraint, rhs: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
    return [lhs] + rhs
}

func + (lhs: NSLayoutConstraint, rhs: NSLayoutConstraint) -> [NSLayoutConstraint] {
    return [lhs, rhs]
}

func += (lhs: inout [NSLayoutConstraint], rhs: NSLayoutConstraint) {
    lhs.append(rhs)
}
