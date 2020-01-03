//
//  SetupButton.swift
//  Loop
//
//  Copyright © 2018 LoopKit Authors. All rights reserved.
//

import UIKit

public class SetupButton: UIButton {
    public var testXyz = 123
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        setup()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func awakeFromNib() {
        super.awakeFromNib()

        setup()
    }

    private func setup() {
        backgroundColor = tintColor
        layer.cornerRadius = 6

        titleLabel?.adjustsFontForContentSizeCategory = true
        contentEdgeInsets.top = 14
        contentEdgeInsets.bottom = 14
        setTitleColor(.white, for: .normal)
    }

    public override func tintColorDidChange() {
        super.tintColorDidChange()

        backgroundColor = tintColor
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        tintColor = .blue
        tintColorDidChange()
    }

    public override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1
        }
    }

    public override var isEnabled: Bool {
        didSet {
            tintAdjustmentMode = isEnabled ? .automatic : .dimmed
        }
    }
    
    // MARK: - activity indicator
    
    private func newActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        return activityIndicator
    }

    private var savedTitle: String?
    private var savedIsEnabled: Bool!
    
    public var testVar: Bool = false
    
    private lazy var activityIndicator = newActivityIndicator()
    
    /// Start indicating activity by rendering a `UIActivityIndicatorView` in place of the button's title text.
    /// The indicator spins until `stopIndicatingActivity` is called.
    
    public var isIndicatingActivity: Bool = false {
        didSet {
            if oldValue == isIndicatingActivity {
                return
            }
            if isIndicatingActivity {
                savedTitle = titleLabel?.text
                savedIsEnabled = isEnabled
                isEnabled = false
                setTitle("", for: .normal)

                activityIndicator.translatesAutoresizingMaskIntoConstraints = false
                self.addSubview(activityIndicator)
                NSLayoutConstraint.activate([
                    self.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor),
                    self.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor)
                ])
                activityIndicator.startAnimating()
            } else {
                if let title = savedTitle {
                    setTitle(title, for: .normal)
                }
                isEnabled = savedIsEnabled
                activityIndicator.stopAnimating()
            }
        }
    }
}
