<br>
<p align="center">
<img src="readmeResources/appIcon.png" class="center" alt="drawing" width="300"/>
</p>
<br>

# MarvelWorldWide
Marvel App

[![Swift](https://img.shields.io/badge/Swift-5.5-orange?style=flat-square)](https://img.shields.io/badge/Swift-5.3_5.4_5.5-Orange?style=flat-square) 
[![Platforms](https://img.shields.io/badge/Platforms-iOS-yellowgreen?style=flat-square)](https://img.shields.io/badge/Platforms-iOS-Green?style=flat-square)

This project based on the Marvel [API](https://developer.marvel.com/docs), some of its features are:

- List characters
- Pagination
- Detail of character (image, information...)
    - Comics where appear
    - Series where appear
- Search filter by name of specific character
- Empty pagination control and non-existing results
- Multilanguage app
- DarkMode support
- Local data caching when entering a character detail

This app is a simple demo to show the functionality of the API with iOS.

## Important

To use Marvel API you should create an account and generate an API key and configure the .xcconfig files depending on the development environment in which we want to launch our application.
Example:[Realease.xcconfig](https://github.com/RapsusMTN/MarvelWorldWide/blob/main/MarvelWorldWide/MarvelWorldWide/Configuration/Environment/Release.xcconfig), changing your created API key.

## Environment

We can launch our app in 3 different development environments **Release**, **Development** and **Debug**, selecting the following targets:

- MarvelWorldWide (Release)
- MarvelWorldWideDevelop (Development)
- MarvelWorldWideDebug (Debug)

Deployment info: **iOS 15.2**

## Testing

To run the unit tests of the app, we must select the **MarvelWorldWideTests** target and press **Command+U**, then the corresponding unit tests will be launched.

## Third Party Libraries

I have used the following libraries to develop the project:

1. Animations with [Lottie](https://lottiefiles.com)
2. Asynchronous download of images with [Kingfisher](https://github.com/onevcat/Kingfisher)
3. Key encryption and network parameters [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift)

I have used [Swift Package Manager](https://developer.apple.com/documentation/swift_packages) for library management

## Database Local

Simulation of saving in a local database with UserDefaults since I have tried to use **ObjectBox** and I have not been able to integrate it with SwiftPackageManager, but it is correctly implemented to be able to refactor the persistence layer with any local database tool.

## Architecture - Functionality - Workflow

1. I have used the **MVVM** architecture pattern with some **VIPER** principles
2. Dependency Injection
3. Native Network layer via [URLSession](https://developer.apple.com/documentation/foundation/urlsession)
4. Facade pattern
5. Protocol-oriented programming
6. Coordinator Pattern.
7. Factory Pattern
8. Communication between layers through closures and [Result](https://developer.apple.com/documentation/swift/result) and manage errors.
9. Using [GitFlow](https://www.atlassian.com/es/git/tutorials/comparing-workflows/gitflow-workflow) metodology and **Pull request** to simulate a real working environment.
10. Singleton Pattern

## Screenshots

In the images below can see some screenshots of the application in **Light** and **Dark** mode.

**Light**

![LightMode](readmeResources/appLight.PNG)

**Dark**

![DarkMode](readmeResources/appDark.PNG)

``` Swift
 let enjoy = "I hope you like it ❤️"
 print(enjoy)
```


**Copyright © 2022 Jorge Martín Reyero. All rights reserved.**
