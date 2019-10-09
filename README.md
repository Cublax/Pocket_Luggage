
# README 🔥

## Architecture

This architecture is split in differents layers/concepts 🏋️‍♀️: 

* `Coordinator`
* `ViewControllers`
* `ViewModels`
* `Repositories`
* `Network`
* `Tests`

### Context 

I Build This Travel App in 3 parts:  

-First is a Translator that allows to change the origin and destination language, it is connected to the google Translate API.
-Second is Meteo tableView, containing my Current Location, Berlin and my hometown Annecy in France. There is current meteological situation but also the forecasts of the next days. I used the OpenWheather API on this one.
-Third part is a Money Converter that allows you to convert an amount of your choice to any currency. I used the fixer.io API to get the current rates, and as I only have the free version the only origin currency possible is Euro, However there is a pickerView to choose any destination currency you like. 

Bonus : 

Translator : TableView pour changer les langues + Switch Button
Météo : Forecasts
Converter : PickerView pour Changer la destination Currency


#### Coordinator:

The Coordinator is a separate entity responsible of the navigation  flow. With the help of the `Screens`, it creates, presents and dismisses `UIViewControllers`, by keeping them separate and independent.
Coordinator can, create and run child coordinators too.

Since a coordinator is responsible of the entire flow of the stack, do not create a coordinator per viewController ☝️.

The only way of using a coordinator, is to instanciate it (by injecting in it if necessary some specific objects) and call the `start()` method, and **that's all**. The entire logic will be encapsulated by delegation for the rest of the navigation.


#### Network:

As indicated by it's name, this layer provides different tools to make requests in an efficient way. First you have to create a client `HTTPClient` and an `URLRequest` or an `HTTPRequest` . At this time `HTTPRequest` are used to fetch Json data and parsing their response in `Codable` objects. For much bigger data like audio or images, you'll need to use basical `URLRequest`. This logic is handled by the `URLSessionEngine`.

Since a request could be cancelled by many different operation (dequeuing a cell, dismissing a view etc..), each request should be sent with a token provided by the caller. If the caller is deinit, so wil the token, and finally the request is cancelled ⚡️.


#### Repository:

This layer is responsible of calling the `Network` layer, and managing the data from it, in order to present it to the viewModel.

You can see that on the top of each repository, a protocol `RepositoryType` will allow us to test everything by dependency injection 💪.

#### ViewModel:

The `ViewModel` encapsulates the whole logic which doesn't have to be in the ViewController. It's divided in two parts :

* **Inputs**: Every event from the viewController needs to be implemented in the viewModel, since it's listening to them. The main event which always need to be added is `viewDidLoad()`.
* **Outputs**: After `viewDidLoad()`, the viewController is listening for some changes from the `viewModel`. For this, the `viewModel` needs to provide reactive var for each data/state needed. The main rule is to keep separate the UI logic between viewModel and viewController, so keep in mind that a viewModel can only `import Foundation` -> reactive var can't provide data from `UIKit` like `UIImage` for example ☝️.

If your viewModel needs a `Repository`, so you'll need to inject a `RepositoryType`, in order to mock it more easily in the tests 🏋️‍♀️

#### ViewController:

The last layer and not the less important 🙇‍♂️. But as it is mentioned in it's name, a `ViewController` only exists for **control**. So, if you want to test it, you'll only provide UI test, since the logic is extracted in the corresponding `ViewModel`. 


#### Tests

Please make sure you have an internet connection, since some of them needs to make direct requests, this parts should be for sure splited in a better way later (like launching network test only if the connection is available etc..).

Press `cmd+u` and let the magic green life be.
