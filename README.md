# CircularCollectionView

## Why to use

If you want to add a custom collection view that scrolls circular this pod is suitable for your app.

## Demo

***Example app***

<img src="https://github.com/phxlle/CircularCollectionView/blob/master/Circular_Collection_View.gif" width="370" height="693">

## Examples

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation
First add this pod to your podfile.
```ruby
pod 'CircularCollectionView', :git => 'https://github.com/phxlle/CircularCollectionView.git', :tag => ‘1.1.3’"
```
When you added the pod run `pod install` and update your project.

Make sure to add a CollectionView in your project.
After you added the CollectionView you have to edit the layout. The layout component will be set to "Flow". Change this to "CircularCollectionViewLayout" and change the module to "CircularCollectionView" as shown below:

<img src="https://github.com/phxlle/CircularCollectionView/blob/master/CollectionViewLayout.png">

Add an item to the Collection View and change it's class to CircularCollectionViewCell:

<img src="https://github.com/phxlle/CircularCollectionView/blob/master/CollectionViewCell.png">


