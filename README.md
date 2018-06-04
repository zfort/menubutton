# MenuButton

<p align="center">
   MenuButton enables you to easily showcase your awesome new app features. <br/> It's designed from the ground up to be fully customized to your needs.
</p>

<br/>

<p align="center">
   <img width="300" src="https://user-images.githubusercontent.com/6384315/40904078-5274ecea-67e2-11e8-9943-35607aa8ab38.gif" alt="Example">
</p>

## Example

The example Application is an excellent way to see `MenuButton` in action. You get a brief look of the available configuration options and how they affect the look and feel of the `ViewController`. Simply open the `MenuButton.xcodeproj` and run the `Example` scheme.

## Installation

### CocoaPods

MenuButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```bash
pod 'MenuButton', '~> 1.0.0'
```

### Manually

If you prefer not to use any of the aforementioned dependency managers, you can integrate MenuButton into your project manually. Simply drag the `Source` Folder into your Xcode project.

## Usage
The following first usage description shows the easiest way of presenting your new app features with `MenuButton`.

### MenuButton
To showcase your awesome new app features, simply setup a [MenuButton](https://github.com/zfort/menubutton/blob/master/MenuButton/Source/Public/MenuButtonView/MenuButtonView.swift) class via InterfaceBuilder or manually.

```swift
// Initialize MenuButton
let menuButtonView = MenuButtonView(frame: CGRect(x: 295.0, y: 587.0, width: 60.0, height: 60.0)
menuButtonView.bindView(self.view)
menuButtonView.onDeselect = { print("view was deselect") }
menuButtonView.onItems = makeItems()
menuButtonView.strokeColor = .red
menuButtonView.borderStrokeColor = .red
menuButtonView.textMenuColor = .blue
```

### MenuItem
The class that configured a [MenuButton](https://github.com/zfort/menubutton/blob/master/MenuButton/Source/Public/MenuButtonView/MenuButtonView.swift)
```swift
// Initialize MenuItems
func makeItems() -> (() -> [MenuItem])  {
        return {
            return [
                MenuItem(image: UIImage(named: "1")!, text: "Go to Mission Chat", action: { print("Clicked at: Go to Mission Chat") }),
                MenuItem(image: UIImage(named: "2")!, text: "Open Flight Plan", action: { print("Clicked at: Open Flight Plan") }),
                MenuItem(image: UIImage(named: "3")!, text: "Complete Mission", action: { print("Clicked at: Complete Mission") }),
                MenuItem(image: UIImage(named: "4")!, text: "Add Media", action: { print("Clicked at: Add Media") }),
                MenuItem(image: UIImage(named: "5")!, text: "Show on Map", action: { print("Clicked at: Show on Map") }),
                MenuItem(image: UIImage(named: "6")!, text: "Send Email to Mission Creator", action: { print("Clicked at: Send Email to Mission Creator") }),
                MenuItem(image: UIImage(named: "7")!, text: "Phone Mission Creator", action: { print("Clicked at: Phone Mission Creator") }),
                MenuItem(image: UIImage(named: "8")!, text: "Hide Mission from Mission List", action: { print("Clicked at: Hide Mission from Mission List") })
            ]
        }
    }
```

The upcoming subsection will explain all properties of a [MenuButton](https://github.com/zfort/menubutton/blob/master/MenuButton/Source/Public/MenuButtonView/MenuButtonView.swift).

#### Configure
##### Calls when user touched background view.
```swift
var onDeselect: (() -> Void)?
```
##### Calls when menu prepared to show. Equivalent of delegate method.
```swift
var onItems: (() -> [MenuItem])?
```
##### The color that will be used in all line. Default value is UIColor.black.
```swift
var strokeColor: UIColor
```
##### The color that will be used for the border. Default value is UIColor.black.
```swift
var borderStrokeColor: UIColor
```
##### The width of the button’s border. Default value is 1.0.
```swift
var borderLineWidth: CGFloat
```
##### The width of the lines. Default value is 2.5.
```swift
var lineWidth: CGFloat
```
##### The distance between lines and border. Default value is 3.3.
```swift
var offset: CGFloat
```
##### The distance between lines. Default value is 8.0.
```swift
var distanceBetweenLines: CGFloat
```
##### Specifies the basic duration of the animation, in seconds. Default value is 0.3.
```swift
var animationDuration: CFTimeInterval
```
##### Specifies the basic text menu color. Default value is UIColor.black.
```swift
var textMenuColor: UIColor
```
##### Specifies the basic text menu font. Default value is systemFont.
```swift
var textMenuFont: UIFont
```
##### Specifies the basic text menu font size. Default value is 17.0.
```swift
var textMenuSize: CGFloat
```
##### Specifies the basic cell menu height. Default value is UIColor.black.
```swift
var menuCellHeight: CGFloat
```
##### Uses only on iPad. Otherwise will be ignoring. Default value is 300.
```swift
var menuWidth: CGFloat
```

## Contributing
Contributions are very welcome 🙌 🤓

## License

```
MenuButton
Copyright (c) 2018 Andrii Starostenko <starostenko@zfort.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
