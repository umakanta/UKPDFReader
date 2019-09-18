# UKPDFReader
[![CI Status](https://img.shields.io/travis/umakanta1987@gmail.com/UKPDFReader.svg?style=flat)](https://travis-ci.org/umakanta1987@gmail.com/UKPDFReader)
[![Version](https://img.shields.io/cocoapods/v/UKPDFReader.svg?style=flat)](https://cocoapods.org/pods/UKPDFReader)
[![License](https://img.shields.io/cocoapods/l/UKPDFReader.svg?style=flat)](https://cocoapods.org/pods/UKPDFReader)
[![Platform](https://img.shields.io/cocoapods/p/UKPDFReader.svg?style=flat)](https://cocoapods.org/pods/UKPDFReader)

UKPDFReader is a simple framework for reading PDF in iOS

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 11.0+
- Swift 4

## Installation

UKPDFReader is available through [CocoaPods](https://cocoapods.org). 

To install it, simply add the following line to your Podfile:

```ruby
pod 'UKPDFReader'
```

```ruby
use_frameworks!
```
Then run `pod install` with CocoaPods 1.0 or newer.

## Usage

### Import Framework
```swift
import UKPDFReader
```

Once the pdf file in NSBundle, get the bundle path
```swift
guard let path = Bundle.main.url(forResource: "swift", withExtension: "pdf") else {
            print("failed to unwrap fileURL")
            return
        }
```

Create an instance of UKPDFViewController by providing 'path of pdf file' and passing self as delegate 
```swift
let pdfViewController = UKPDFViewController(pdfUrl: path, delegate: self)
```

Customize the PDFReader by providing some values. All values are optional
```swift
  pdfViewController.pdfDisplayDirection = .horizontal
  pdfViewController.showContentsButton = true
  pdfViewController.pdfTitle = "UKPdfReader"
  
  pdfViewController.customizeNavBar(titleTextcolor: .red, titleFont: UIFont.boldSystemFont(ofSize: 24.0), buttonTextcolor: .blue, buttonFont: UIFont.boldSystemFont(ofSize: 18.0))
```

Then, Presenting the UKPDFViewController
```swift
let navController = UINavigationController.init(rootViewController: pdfViewController)
present(navController, animated: true, completion: nil)
```


## License

UKPDFReader is available under the MIT license. See the LICENSE file for more info.
