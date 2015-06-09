# Cutaway

[![CI Status](http://img.shields.io/travis/Fabio Rodella/Cutaway.svg?style=flat)](https://travis-ci.org/Fabio Rodella/Cutaway)
[![Version](https://img.shields.io/cocoapods/v/Cutaway.svg?style=flat)](http://cocoapods.org/pods/Cutaway)
[![License](https://img.shields.io/cocoapods/l/Cutaway.svg?style=flat)](http://cocoapods.org/pods/Cutaway)
[![Platform](https://img.shields.io/cocoapods/p/Cutaway.svg?style=flat)](http://cocoapods.org/pods/Cutaway)

Even for moderately complex apps, it soon becomes clear that having a single storyboard file for everything gets unmanageable pretty quickly. As a solution, we can have multiple storyboards and instantiate view controllers manually, yet not having to write code to perform transitions is pretty great. 

The best of both worlds would be to have segues that can cross storyboard boundaries. Xcode 7 (announced at WWDC 2015) allows just that, but it seems likely that this feature will be limited to iOS 9. 

If you still need to support iOS 7+, fret not, because now there is **Cutaway**. The goals for this project are:

* **The storyboard is the source of truth**: all information for segue destinations is available in the storyboard file itself.
* **No segue subclassing**: any segue type can link to a different storyboard (including `embed` segues, which can't be subclassed).
* **No child view controllers**: the destination view controller you get in a segue is exactly what you expected, not wrapped by any container.
* **Transparently support unwind segues**.

**Cutaway** achieves these, and while not 100% future-proof (it uses method swizzling in the `UIStoryboard` class), it tries to do this in the least intrusive way possible. Once you're ready to migrate to iOS 9 exclusively, all you need to do is replace the placeholder view controllers with native storyboard references and reconnect your segues.

## Usage

The first step is to break your storyboard into smaller, feature-focused storyboards as needed. Then, whenever you need a segue to another storyboard you'd do the following:

* Make sure your destination scene has a meaningful storyboard ID. Also, do use the period symbol (`.`) in the identifier. 

![Storyboard screenshot](https://github.com/fabiorodella/Cutaway/blob/master/Screenshots/ss_destination_id.png)

* Create a placeholder view controller in your origin storyboard. You can use any `UIViewController` subclass, and add any content to it (it's useful to have at least a label describing where that is being linked to). Link your segue(s) to that view controller. 

![Storyboard screenshot](https://github.com/fabiorodella/Cutaway/blob/master/Screenshots/ss_vc_placeholder.png)

* Add a storyboard ID to the placeholder view controller in the following format: `cutaway.StoryboardNameWithoutExtension.DestinationViewControllerID` (the `cutaway` previx can be changed by calling `[UIStoryboard cutaway_setIdentifierPrefix:]`). 

![Storyboard screenshot](https://github.com/fabiorodella/Cutaway/blob/master/Screenshots/ss_cutaway_id.png)

That's all! When performing the segue, **Cutaway** will automatically instantiate the destination view controller and provide it transparently. You can handle that segue using `prepareForSegueWithIdentifier:sender:` as usual.

We have an example project you can try by running:

```
pod try Cutaway
```


Or you can clone the repo, and run `pod install` from the Example directory first.

## Requirements

* iOS 7.0+
* ARC

## Installation

**Cutaway** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Cutaway"
```

You can also manually install it by adding the following files to your project:

* `UIStoryboard+Cutaway.h`
* `UIStoryboard+Cutaway.m`

## Author

Fabio Rodella, fabiorodella@gmail.com

## License

Cutaway is available under the MIT license. See the LICENSE file for more info.
