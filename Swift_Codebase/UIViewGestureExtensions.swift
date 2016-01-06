import UIKit

extension UIView {
    
    typealias TapResponseClosure = (tap: UITapGestureRecognizer) -> Void
    typealias PanResponseClosure = (pan: UIPanGestureRecognizer) -> Void
    typealias SwipeResponseClosure = (swipe: UISwipeGestureRecognizer) -> Void
    typealias PinchResponseClosure = (pinch: UIPinchGestureRecognizer) -> Void
    typealias LongPressResponseClosure = (longPress: UILongPressGestureRecognizer) -> Void
    typealias RotationResponseClosure = (rotation: UIRotationGestureRecognizer) -> Void
    
    private struct ClosureStorage {
        static var TapClosureStorage: [UITapGestureRecognizer : TapResponseClosure] = [:]
        static var PanClosureStorage: [UIPanGestureRecognizer : PanResponseClosure] = [:]
        static var SwipeClosureStorage: [UISwipeGestureRecognizer : SwipeResponseClosure] = [:]
        static var PinchClosureStorage: [UIPinchGestureRecognizer : PinchResponseClosure] = [:]
        static var LongPressClosureStorage: [UILongPressGestureRecognizer: LongPressResponseClosure] = [:]
        static var RotationClosureStorage: [UIRotationGestureRecognizer: RotationResponseClosure] = [:]
    }
    
    private struct Swizzler {
        private static var OnceToken : dispatch_once_t = 0
        static func Swizzle() {
            dispatch_once(&OnceToken) {
                let UIViewClass: AnyClass! = NSClassFromString("UIView")
                let originalSelector = Selector("removeFromSuperview")
                let swizzleSelector = Selector("swizzled_removeFromSuperview")
                let original: Method = class_getInstanceMethod(UIViewClass, originalSelector)
                let swizzle: Method = class_getInstanceMethod(UIViewClass, swizzleSelector)
                method_exchangeImplementations(original, swizzle)
            }
        }
    }
    
    func swizzled_removeFromSuperview() {
        self.removeGestureRecognizersFromStorage()
        /* 
        Will call the original representation of removeFromSuperview, not endless cycle:
        http://darkdust.net/writings/objective-c/method-swizzling
        */
        self.swizzled_removeFromSuperview()
    }
    
    func removeGestureRecognizersFromStorage() {
        if let gestureRecognizers = self.gestureRecognizers {
            for recognizer: UIGestureRecognizer in gestureRecognizers {
                if let tap = recognizer as? UITapGestureRecognizer {
                    ClosureStorage.TapClosureStorage[tap] = nil
                }
                else if let pan = recognizer as? UIPanGestureRecognizer {
                    ClosureStorage.PanClosureStorage[pan] = nil
                }
                else if let swipe = recognizer as? UISwipeGestureRecognizer {
                    ClosureStorage.SwipeClosureStorage[swipe] = nil
                }
                else if let pinch = recognizer as? UIPinchGestureRecognizer {
                    ClosureStorage.PinchClosureStorage[pinch] = nil
                }
                else if let rotation = recognizer as? UIRotationGestureRecognizer {
                    ClosureStorage.RotationClosureStorage[rotation] = nil
                }
                else if let longPress = recognizer as? UILongPressGestureRecognizer {
                    ClosureStorage.LongPressClosureStorage[longPress] = nil
                }
            }
        }
    }
    
    // MARK: Taps
    func addSingleTapGestureRecognizerWithResponder(responder: TapResponseClosure) {
        self.addTapGestureRecognizerForNumberOfTaps(withResponder: responder)
    }
    
    func addDoubleTapGestureRecognizerWithResponder(responder: TapResponseClosure) {
        self.addTapGestureRecognizerForNumberOfTaps(2, withResponder: responder)
    }
    
    func addTapGestureRecognizerForNumberOfTaps(numberOfTaps: Int = 1, numberOfTouches: Int = 1, withResponder responder: TapResponseClosure) {
        let tap = UITapGestureRecognizer()
        tap.numberOfTapsRequired = numberOfTaps
        tap.numberOfTouchesRequired = numberOfTouches
        tap.addTarget(self, action: "handleTap:")
        self.addGestureRecognizer(tap)

        ClosureStorage.TapClosureStorage[tap] = responder
        Swizzler.Swizzle()
    }
    
    func handleTap(sender: UITapGestureRecognizer) {
        if let closureForTap = ClosureStorage.TapClosureStorage[sender] {
            closureForTap(tap: sender)
        }
    }
    
    // MARK: Pans
    func addSingleTouchPanGestureRecognizerWithResponder(responder: PanResponseClosure) {
        self.addPanGestureRecognizerForNumberOfTouches(1, withResponder: responder)
    }
    
    func addDoubleTouchPanGestureRecognizerWithResponder(responder: PanResponseClosure) {
        self.addPanGestureRecognizerForNumberOfTouches(2, withResponder: responder)
    }
    func addPanGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: PanResponseClosure) {
        let pan = UIPanGestureRecognizer()
        pan.minimumNumberOfTouches = numberOfTouches
        pan.addTarget(self, action: "handlePan:")
        self.addGestureRecognizer(pan)
        
        ClosureStorage.PanClosureStorage[pan] = responder
        Swizzler.Swizzle()
    }
    
    func handlePan(sender: UIPanGestureRecognizer) {
        if let closureForPan = ClosureStorage.PanClosureStorage[sender] {
            closureForPan(pan: sender)
        }
    }
    
    // MARK: Swipes
    func addLeftSwipeGestureRecognizerWithResponder(responder: SwipeResponseClosure) {
        self.addLeftSwipeGestureRecognizerForNumberOfTouches(1, withResponder: responder)
    }
    func addLeftSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: SwipeResponseClosure) {
        self.addSwipeGestureRecognizerForNumberOfTouches(numberOfTouches, forSwipeDirection: .Left, withResponder: responder)
    }
    
    func addRightSwipeGestureRecognizerWithResponder(responder: SwipeResponseClosure) {
        self.addRightSwipeGestureRecognizerForNumberOfTouches(1, withResponder: responder)
    }
    func addRightSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: SwipeResponseClosure) {
        self.addSwipeGestureRecognizerForNumberOfTouches(numberOfTouches, forSwipeDirection: .Right, withResponder: responder)
    }
    
    func addUpSwipeGestureRecognizerWithResponder(responder: SwipeResponseClosure) {
        self.addUpSwipeGestureRecognizerForNumberOfTouches(1, withResponder: responder)
    }
    func addUpSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: SwipeResponseClosure) {
        self.addSwipeGestureRecognizerForNumberOfTouches(numberOfTouches, forSwipeDirection: .Up, withResponder: responder)
    }
    
    func addDownSwipeGestureRecognizerWithResponder(responder: SwipeResponseClosure) {
        self.addDownSwipeGestureRecognizerForNumberOfTouches(1, withResponder: responder)
    }
    func addDownSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: SwipeResponseClosure) {
        self.addSwipeGestureRecognizerForNumberOfTouches(numberOfTouches, forSwipeDirection: .Down, withResponder: responder)
    }
    
    func addSwipeGestureRecognizerForNumberOfTouches(numberOfTouches: Int, forSwipeDirection swipeDirection: UISwipeGestureRecognizerDirection, withResponder responder: SwipeResponseClosure) {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = swipeDirection
        swipe.numberOfTouchesRequired = numberOfTouches
        swipe.addTarget(self, action: "handleSwipe:")
        self.addGestureRecognizer(swipe)
        
        ClosureStorage.SwipeClosureStorage[swipe] = responder
        Swizzler.Swizzle()
    }

    func handleSwipe(sender: UISwipeGestureRecognizer) {
        if let closureForSwipe = ClosureStorage.SwipeClosureStorage[sender] {
            closureForSwipe(swipe: sender)
        }
    }
    
    // MARK: Pinches
    func addPinchGestureRecognizerWithResponder(responder: PinchResponseClosure) {
        let pinch = UIPinchGestureRecognizer()
        pinch.addTarget(self, action: "handlePinch:")
        self.addGestureRecognizer(pinch)
        
        ClosureStorage.PinchClosureStorage[pinch] = responder
        Swizzler.Swizzle()
    }
    
    func handlePinch(sender: UIPinchGestureRecognizer) {
        if let closureForPinch = ClosureStorage.PinchClosureStorage[sender] {
            closureForPinch(pinch: sender)
        }
    }
    
    // MARK: LongPress
    func addLongPressGestureRecognizerWithResponder(responder: LongPressResponseClosure) {
        self.addLongPressGestureRecognizerForNumberOfTouches(1, withResponder: responder)
    }
    func addLongPressGestureRecognizerForNumberOfTouches(numberOfTouches: Int, withResponder responder: LongPressResponseClosure) {
        let longPress = UILongPressGestureRecognizer()
        longPress.numberOfTouchesRequired = numberOfTouches
        longPress.addTarget(self, action: "handleLongPress:")
        self.addGestureRecognizer(longPress)
        
        ClosureStorage.LongPressClosureStorage[longPress] = responder
        Swizzler.Swizzle()
    }
    
    func handleLongPress(sender: UILongPressGestureRecognizer) {
        if let closureForLongPinch = ClosureStorage.LongPressClosureStorage[sender] {
            closureForLongPinch(longPress: sender)
        }
    }
    
    // MARK: Rotation
    func addRotationGestureRecognizerWithResponder(responder: RotationResponseClosure) {
        let rotation = UIRotationGestureRecognizer()
        rotation.addTarget(self, action: "handleRotation:")
        self.addGestureRecognizer(rotation)
        
        ClosureStorage.RotationClosureStorage[rotation] = responder
        Swizzler.Swizzle()
    }
    
    func handleRotation(sender: UIRotationGestureRecognizer) {
        if let closureForRotation = ClosureStorage.RotationClosureStorage[sender] {
            closureForRotation(rotation: sender)
        }
    }
}