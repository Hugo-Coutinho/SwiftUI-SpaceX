# SpaceX
<div style="text-align: center">
    <table>
        <tr>
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/filtering.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/opening.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/scrolling.gif?raw=true" width="200" height="350"/>
                </a>
            </td>            
        </tr>
        <tr>         
            <td style="text-align: center">
                    <img src="https://github.com/Hugo-Coutinho/SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/sorting.gif?raw=true" width="200" height="350"/>
                </a>
            </td>              
        </tr>
    </table>
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

### Installing

**Cloning the Repository**

```swift
$ git clone https://github.com/Hugo-Coutinho/SpaceX.git

$ cd SpaceX
```

**Installing dependencies**

```swift
$ pod install
```

## Built With

- [Nuke](https://github.com/kean/Nuke) - Image Loading System


## Contributing

You can send how many PR's do you want, I'll be glad to analyse and accept them! And if you have any question about the project...

Email-me: hugocoutinho2011@gmail.com

Connect with me at [LinkedIn](https://www.linkedin.com/in/hugo-coutinho-aaa3b0114/?locale=en_US)

Check my development techniques: [My personal study annotations](http://bloghugocoutinho.wordpress.com)

Thank you!

## Explaining with diagrams how I'm using VIPE and clean architecture for this project

### Decoupled ViewController with tableViewController and their sections
Here in this case on the main screen, I'm printing the SpaceX information and a rocket launch list. In my navigationBar I put a search to be able to filter the launches by the year. 

My inheritance with UIKit it's up to the TableviewController to do it. My ViewController extends TableViewController and their only responsibility is starting the sections using their builder and implements their output.
With this design basically my ViewController became a section manager. Completely decoupled it doesn't know nothing about the sections and their logics. Using the section builder and communicating with sectionInput protocol ViewController it's isolated not having any reference directly to sections being able to delete/refactor/new features without breaking nothing into it.

Unfortunately, I break some solid principles in this case creating a direct reference of my ViewController into LaunchSection, I did this faster solution that the LaunchSection be able to implement the search Bar delegates and then filtering the launches by year.A side solution that for me suit better not breaking any solid principles it is given the launch request logic and filtering all the stuff responsibility to ViewController itself, and only passing the launch list to the launchBuilder. That way I'll continue following the good principles

<div align="center">
<img src="https://github.com/Hugo-Coutinho/SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/view_controller_architecture.png?raw=true"/>
</div>

### Breaking VIPE into mini VIPE for each section
Looking at the section landscape, his responsibility is to do everything related to launch and just that. This section doesn't know nothing about the tableview logic and the viewController management, it's isolated.

Thus, launch section has to do the launch networking, business logic, formatting and presentation and rendering user events and updating launch data. And it does, using clean architecture and VIPE UI design pattern.

As you can see below in the diagram, I like to work with a single cell for each state, so I have an error, a loading and a success, and the section does the state management.

To respect the uncle Bob clean architecture design, I like to use the encapsulation pilar from OOP to isolate my application from external frameworks. Here I'm using Nuke pod to help me with load images and caches, but I don't want to my UI import external frameworks, because doing this I'm becoming a hostage to it. So I had created an Adapter isolating my UI to know Nuke and I'm using the adapter where I need. So in this way, I'm continuing using the benefits of Nuke and the same time not depending onto external applications.

<div align="center">
<img src="https://github.com/Hugo-Coutinho/SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/encapsulation_with_section_tableviewcell.png?raw=true"/>
</div>

### VIPE with diagrams
I'm using protocol to follow the solid principles, for example, creating an output and input interface for each layer so the communication between layers are being with protocols, so presenter doesn't know the interactor and section, and the interactor doesn't know service and presenter. So we have a dependency inversion here.

Using the communication between interactor and presenter for example, we have a presenter holding reference of interactorInput, and implements their output, in this case as you can see in the diagram below, I'm creating a retain cycle because this parent child relation the arc can't deallocated, so to avoid the retain cycle inside of *launchInteractor* I put the output reference as weak.

About the layers communication I'm using closure and delegates, closure of the service to the interactor, and after that using output delegate to the rest.

The launch data that I get from networking requests until to be ready into section, pass through some changes. Starting with service getting the Data and passing by closure to the interactor, interactor do the job of decoding into an entity and then passing to the presenter, presenter now gets the entity and pass to the section a domain instance with all business logic resolved. So the section and the cells only know the domain and nothing else.

About the domain, I like to work with a concrete domain reference and a domain for each mini vipe design pattern, but the cons of this approach it that isn't able to reuse this domain in others feature. Domain for me has all the business logic and he can resolve itself transforming the entity into a viewdata.

<div align="center">
<img src="https://github.com/Hugo-Coutinho/SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/vipe.png?raw=true"/>
</div>

### Repository structure
In this application I created a BaseRequest that access the URLSession for networking, this BaseRequest it's a reusable service with an input protocol, so every service has reference to the input protocol and not the concrete BaseRequest following the dependency inversion principle. They responsibility it's only getting the data and pass by a closure.

<div align="center">
<img src="https://github.com/Hugo-Coutinho/SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/Repository_structure.png?raw=true"/>
</div>

### My Clean Architecture
Following uncle Bob clean architecture design we have 4 rings, one inside the other:
1. The blue one it's supposed to be exclusive for UI and external Frameworks
2. The green one, it's That when we create our view Controller and our adapter from external libraries
3. The orange one, it's responsible for all the application business logic
4. The smaller yellow ring supposed to be the entities

Now looking from the smallest ring to the biggest the only one that can know entity should be the use case, it means viewController cannot know entity only the domain.
Our controllers and adapters has a reference from use case (domain) totally don't knowing business logic and data formatting.

Using encapsulation I'm protecting my application for external stuffs as you can see the blue biggest ring we have external but inside of it, I'm using an adapter so if something happens to the library or if I just want to not use it anymore I can simply remove from the project and anything won't gonna break or change.
At below you can see the rings with my solution.

<div align="center">
<img src="https://github.com/Hugo-Coutinho/SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/clean_architecture.png?raw=true"/>
</div>

### The solid principles power for unit testing as well
How can I do unit testing for all the VIPE layers with fixture data?
Simple, with one interface, following open and closed principle that says open for extension but closed for modifications. I can extend my BaseRequest to the error scenario and for the success scenario. For the success I can just get the Json and start the test flow.

Take a look at the diagram below and you can see that I'm using the BaseRequestInput as a boundary for the spies and the concrete BaseRequest.

<div align="center">
<img src="https://github.com/Hugo-Coutinho/SpaceX/blob/master/SpaceX/Core/Helper/readme%20gifs/base_request_architecture.png?raw=true"/>
</div>



