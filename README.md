# SpaceX
<p float="left">
  <img src="https://github.com/Hugo-Coutinho/SwiftUI-SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/filtering.gif?raw=true" width="250"/>
  <img src="https://github.com/Hugo-Coutinho/SwiftUI-SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/scrolling.gif?raw=true" width="250"/>
  <img src="https://github.com/Hugo-Coutinho/SwiftUI-SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/sorting.gif?raw=true" width="250"/>
</p>

## SwiftUI

New Apple Framework to create the UI, coding with Swift and now with declarative progamming paradigm. UIKit uses imperative programming paradigm, that means we need to handle manipulating the elements dragging and dropping. With SwiftUI declarative way, we just say what we want and it´s done.

For example, building a form with UIKit might require you to control details like this:

– Create a vertical UIStackView element.

– Add two auto layout contraints (rules) to center it on the X-axis and Y-axis of the root view.

– Create a UITextField element.

– Add it into the UIStackView.

And Now Building with SwiftUI Here’s what that looks like:

– Hey SwiftUI, I want to group two textfields and a button in a vertical stack on the screen. SwiftUI will then go and create the elements and put them into the view and arrange them in a vertical stack.

## Combine

It´s a functional reactive programming, that means is driven by event. Working observing services and subscribing the result and automatically updating the UI regarding the new values.

Nowadays a big group of developers have preference of working with MVVM and reactive way with RXSwift. So, with this new framework the trend is to move out to Combine.

## Replacing VIPER to MVVM

<div align="left">
<img src="https://bloghugocoutinho.files.wordpress.com/2022/09/image-1.png"/>
</div>


I use to work with Viper that is my favourite design pattern + clean architecture. Using Builder to dependency injection and Domain to format data and prepare for the view.

But SwiftUI in a declarative way and Combine in the reactive paradigm, VIPER it is far to be the best architecture to use. MVVM fits perfect for this occasion.

<div align="left">
<img src="https://bloghugocoutinho.files.wordpress.com/2022/09/image-2.png"/>
</div>

Basically, the changes are removing Presenter and Interactor layers and putting ViewModel making kind the same as Domain in VIPER, but now in the reactive flow.

Serialising data and business logic It’s responsibility to Interactor, with MVVM, I can use a modifier to decode data into my entity and with small business logic, I make work inside the service Layer. Otherwise, I would create a Repository layer for this duty.

## Working with Combine

In a big picture explanation, the SwiftUI view will observe an object. And that object will subscribe to receive new values from API, and the object will decode the data and to map for the views to use it.

<div align="left">
<img src="https://bloghugocoutinho.files.wordpress.com/2022/09/image-3.png"/>
</div>

The image above shows that we still use URLSession but a bit different, instead of using completion with the Data or Error, we are returning AnyPublisher of Data or of Error. But for doing that we need to map the response and also the error if occur

<div align="left">
<img src="https://bloghugocoutinho.files.wordpress.com/2022/09/image-7.png"/>
</div>

In the ViewModel layer, we decode and map transforming the Entity into the ViewModel Object handling all the logic necessary. Afterwards, we assign it into a published property. That published property will be used in the UI.

## SwiftUI Structure

SwiftUI gives us an amazingly declarative approach to programming our user interfaces. Consider the following code:

<div align="left">
<img src="https://bloghugocoutinho.files.wordpress.com/2022/09/image-8.png"/>
</div>

Just Writing up the elements that you want to add and using the modifiers for each element to configure it.

Remark on what is the difference between LazyVStack and VStack and when to use LazyStackView:

VStack build all the sub views at once and Lazy build the sub views that will appear.

**good case to use VStack:** Almost all the cases, when we have a number of sub views defined or at least we know that the number of sub views is not gigantic.

**good case to use LazyVStack:** it’s certain that the number of sub views is big or is dynamic.

## Property Wrapper

A property wrapper it’s useful for when we have common definitions for some properties. Actually is not only common definitions, but with some settings that you have to make that repeat in some places.

Example:

```swift
extension UserDefaults {

    @UserDefault(key: "has_seen_app_introduction", defaultValue: false)
    static var hasSeenAppIntroduction: Bool
}
```

The @UserDefault statement is a call into the property wrapper. As you can see, we can give it a few parameters that are used to configure the property wrapper. There are several ways to interact with a property wrapper, like using the wrapped value and the projected value. You can also set up a property wrapper with injected properties.

Here are explanation of the most used property wrappers in SwiftUI:

**@State**

Make able us to modify value inside a Struct. Structs are value type, so usually modifications are not allowed. Thus, putting @State before a property, we are moving out the storage from the struct.

Another explanation is that swiftUI views are always rendering and updating, you have to declare @State if your value should´nt update with the view.

**@Binding**

To hold state of values from superView. It doesn’t work well if you have some few levels deep to pass data through, for this case we have a much better property wrapper called EnvironmentObject.

**@EnvironmentObject**

Useful for inject dependency into swiftUI and all the child views can access it. The object that you pass in an environment object will live in the current environment.

**@Published**

It´s the most important property wrapper of swiftUI. With it, we can create observable objects and reload the views to reflect those changes that is using the published.

**@ObservedObject**

ObservableObject it´s a protocol that enables us to observe objects in the swiftUI and combined with published property wrapper, we can listen every new value and update the UI.

Normally my SwiftUI structs has dependency of ObservedObject viewModels, and for each var that I will use in the view, I have to declare as published.

## Snapshot Testing

Saving an image of your screen to define how your UI should be and test with your current Screen to prevent bad modifications.

When an assertion first runs, a snapshot is automatically recorded to disk and the test will fail, printing out the file path of any newly-recorded reference.

<div align="left">
<img src="https://bloghugocoutinho.files.wordpress.com/2022/09/image-9.png"/>
</div>

Now re-run the test and will pass.

<div align="left">
<img src="https://bloghugocoutinho.files.wordpress.com/2022/09/image-10.png"/>
</div>

## About this Project

The idea of the App is:

" *Listing the SpaceX information and rocket launches. It's possible to sort the launches by ascendent or descendent and filtering by launch year as well* ".

## Why?

This project is part of my personal portfolio, so, I'll be happy if you could provide me any feedback about the project, code, structure or anything that you can report that could make me a better developer!

Email-me: hugocoutinho2011@gmail.com

Connect with me at [LinkedIn](https://www.linkedin.com/in/hugo-coutinho-aaa3b0114/?locale=en_US).

Also, you can use this Project as you wish, be for study, be for make improvements or earn money with it!
It's free!

## Built With

- [Nuke](https://github.com/kean/Nuke) - Image Loading System

- [KIF](https://github.com/kif-framework/KIF) - Keep It Functional - An iOS Functional Testing Framework


## Contributing

You can send how many PR's do you want, I'll be glad to analyse and accept them! And if you have any question about the project...

Email-me: hugocoutinho2011@gmail.com

Connect with me at [LinkedIn](https://www.linkedin.com/in/hugo-coutinho-aaa3b0114/?locale=en_US)

Check my development techniques: [My personal study annotations](http://bloghugocoutinho.wordpress.com)

Thank you!
