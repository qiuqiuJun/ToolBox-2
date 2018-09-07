//
//  EFColorSelectionViewController.swift
//  EFColorPicker
//
//  Created by EyreFree on 2017/9/29.
//
//  Copyright (c) 2017 EyreFree <eyrefree@eyrefree.org>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit

// The delegate of a EFColorSelectionViewController object must adopt the EFColorSelectionViewController protocol.
// Methods of the protocol allow the delegate to handle color value changes.
public protocol EFColorSelectionViewControllerDelegate: class {

    // Tells the data source to return the color components.
    // @param colorViewCntroller The color view.
    // @param color The new color value.
    func colorViewController(colorViewCntroller: EFColorSelectionViewController, didChangeColor color: UIColor)
}

public class EFColorSelectionViewController: UIViewController, EFColorViewDelegate,DYSegmentedControlDelegate {

    // The controller's delegate. Controller notifies a delegate on color change.
    public weak var delegate: EFColorSelectionViewControllerDelegate?

    // The current color value.
    public var color: UIColor {
        get {
            return self.colorSelectionView().color
        }
        set {
            self.colorSelectionView().color = newValue
        }
    }

    // Whether colorTextField will hide, default is `true`
    public var isColorTextFieldHidden: Bool {
        get {
            return !((self.view as? EFColorSelectionView)?.hsbColorView.brightnessView.colorTextFieldEnabled ?? false)
        }
        set {
            if let colorSelectionView = self.view as? EFColorSelectionView,
                colorSelectionView.hsbColorView.brightnessView.colorTextFieldEnabled != !newValue {
                colorSelectionView.hsbColorView.brightnessView.colorTextFieldEnabled = !newValue

                for colorComponentView in colorSelectionView.rgbColorView.colorComponentViews {
                    colorComponentView.colorTextFieldEnabled = !newValue
                }
            }
        }
    }
    lazy var segmentedControl:TBSegmentedControl = {
        
        var array:NSArray = ["RGB","选色板"]
        var titleTextAttributes:NSMutableDictionary = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColorFromRGB(rgbValue: 0x666666)]
        var selectedTitleTextAttributes:NSMutableDictionary = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14),NSAttributedStringKey.foregroundColor:UIColorFromRGB(rgbValue: 0xff5548)]
        var mySeg = TBSegmentedControl.init(frame: CGRect( x:0,y: 0,width: self.view.frame.width,height:50), segmentWidthStyle: DYSegmentedControlSegmentWidthStyleContentFit, segmentEdgeInset: UIEdgeInsetsMake(0, 6, 0, 6), selectionIndicatorSize: CGSize.init(width: 40, height: 2), titleTextAttributes: titleTextAttributes as! [AnyHashable : Any], selectedTitleTextAttributes: selectedTitleTextAttributes as! [AnyHashable : Any])
            mySeg?.delegate = self;
            mySeg?.sectionTitles = array as! [String]
            return mySeg!
        
        }()
//    - (UIView *)segmentedControl {
//    if (!_segmentedControl) {
//    NSArray *_sectionTitlesArray = @[@"精选",
//    @"电影",
//    //@"电视剧"
//    ];
//    NSDictionary *titleTextAttributes = @{NSFontAttributeName : kDYCircleNormalChannelFont,
//    NSForegroundColorAttributeName : kDYCircleNormalChannelColor};
//    NSDictionary *selectedTitleTextAttributes = @{NSFontAttributeName : kDYCircleSelectedChannelFont,
//    NSForegroundColorAttributeName : kDYCircleSelectedChannelColor};
//    _segmentedControl = [[DYSegmentedControl alloc]
//    initWithFrame:CGRectMake(0, 0, self.view.width, ksegmentedControlHeight)
//    segmentWidthStyle:DYSegmentedControlSegmentWidthStyleContentFit
//    segmentEdgeInset:UIEdgeInsetsMake(0, 6, 0, 6)
//    selectionIndicatorSize:CGSizeMake(40, 2)
//    titleTextAttributes:titleTextAttributes
//    selectedTitleTextAttributes:selectedTitleTextAttributes];
//    _segmentedControl.delegate = self;
//    _segmentedControl.sectionTitles = _sectionTitlesArray;
//    }
//    return _segmentedControl;
//    }

    
    override public func loadView() {
        let colorSelectionView: EFColorSelectionView = EFColorSelectionView(frame: UIScreen.main.bounds)
        self.view = colorSelectionView
    }
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.segmentedControl);
        self.segmentedControl.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(StatusBarHeight())
            make.height.equalTo(50)
        }
//
//        let segmentControl: UISegmentedControl = UISegmentedControl(
//            items: [NSLocalizedString("RGB", comment: ""), NSLocalizedString("HSB", comment: "")]
//        )
//        segmentControl.addTarget(
//            self,
//            action: #selector(segmentControlDidChangeValue(_:)),
//            for: UIControlEvents.valueChanged
//        )
//        segmentControl.selectedSegmentIndex = 0
//        self.navigationItem.titleView = segmentControl

        self.colorSelectionView().setSelectedIndex(index: EFSelectedColorView.RGB, animated: false)
        self.colorSelectionView().delegate = self
//        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    }

    @IBAction func segmentControlDidChangeValue(_ segmentedControl: UISegmentedControl) {
        self.colorSelectionView().setSelectedIndex(
            index: EFSelectedColorView(rawValue: segmentedControl.selectedSegmentIndex) ?? EFSelectedColorView.RGB,
            animated: true
        )
    }

    override public func viewWillLayoutSubviews() {
        self.colorSelectionView().setNeedsUpdateConstraints()
        self.colorSelectionView().updateConstraintsIfNeeded()
    }

    func colorSelectionView() -> EFColorSelectionView {
        return self.view as? EFColorSelectionView ?? EFColorSelectionView()
    }

    // MARK:- EFColorViewDelegate
    public func colorView(colorView: EFColorView, didChangeColor color: UIColor) {
        self.delegate?.colorViewController(colorViewCntroller: self, didChangeColor: color)
    }
    public func segmentedControl(_ segmentedControl: TBSegmentedControl!, indexChanged index: Int) {
        self.colorSelectionView().setSelectedIndex(
            index: EFSelectedColorView(rawValue: segmentedControl.selectedSegmentIndex) ?? EFSelectedColorView.RGB,
            animated: true
        )
    }
}
