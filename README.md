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

Add an item to the Collection View and change it's class to CircularCollectionViewCell. Don't forget to name your identifier:

<img src="https://github.com/phxlle/CircularCollectionView/blob/master/CollectionViewCell.png">

Make sure to import this in your viewcontroller:
```Swift
import CircularCollectionView
````

Add the CollectionView in your ViewController:
```Swift
@IBOutlet weak var circularCollection: UICollectionView!
````
After you added your CollectionView you can start editing the DataSource & Delegate:
```Swift
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CircularCollectionViewCell", for: indexPath) as! CircularCollectionViewCell
return cell
}
```
In this function you can add some stuf to your cells.
For the example I used the following code to add an image to the CircularCollectionViewCell:
```Swift
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CircularCollectionViewCell", for: indexPath) as! CircularCollectionViewCell
DispatchQueue.main.async {
let imageView = UIImageView(frame: CGRect(x: 25, y: 0, width: 100, height: 100))
imageView.image = UIImage(named: Constants.images[indexPath.row])
imageView.contentMode = .scaleToFill
imageView.layer.cornerRadius = imageView.frame.size.width/2
imageView.clipsToBounds = true
imageView.layer.borderWidth = 1.0
imageView.layer.borderColor = UIColor.white.cgColor
cell.addSubview(imageView)
}
return cell
}
```
For more information you can check the Example project.

## Requirements

Swift 4.0, Xcode 9

## Author

[Twitter](https://twitter.com/PAsselbergh)

[LinkedIn](https://www.linkedin.com/in/philippeasselbergh/)

## License

CircularCollectionView is available under the MIT license. See the LICENSE file for more info.
