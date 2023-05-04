# Pokédex
Pokédex is an iOS app built using Swift, SwiftUI, and MVVM architecture that allows you to add, search, filter, and view details of Pokemons.

## Features

- Add a new Pokemon with name, type, image, and description
- Search for Pokemons by name or type
- Filter Pokemons by type
- View details of each Pokemon, including its name, image, type, description, and statistics

## Requirements
iOS 14.0+
Xcode 12.5+
Swift 5.4+

## Installation

Clone or download the repository.
Open the Pokédex.xcodeproj file in Xcode.
Build and run the app on a simulator or a physical device.

## Usage

On the Home screen, you can see a list of all the Pokemons you've added. Tap the "+" button to add a new Pokemon.
On the Add screen, enter the name, type, image, and description of the new Pokemon. Tap the "Save" button to add it to the list.
Use the search bar to search for a Pokemon by name or type. The search results will be updated in real-time.
Use the filter button to filter Pokemons by type. You can select multiple types at once.
Tap on a Pokemon in the list to view its details on the Details screen. Here, you can see the name, image, type, description, and statistics of the Pokemon.

## Architecture

The app is built using the Model-View-ViewModel (MVVM) architecture pattern. Here's a brief overview of the different layers:

## Model

The data layer that represents the app's data and business logic. In this app, the models are the Pokemon and PokemonType structs.
## View

The UI layer that displays the data to the user and handles user input. In this app, the views are implemented using SwiftUI.
ViewModel: The glue layer that connects the view and the model. The view model handles the business logic and provides the data to the view. 
