# Amiibo Search Finder

Amiibo Search Finder is a Flutter app that allows users to search and explore Amiibo figures. The app fetches Amiibo data from the AmiiboAPI and displays it in a grid view. Users can search for specific Amiibos, view their details, and save their favorite Amiibos to a list.

## Features

- Fetches Amiibo data from AmiiboAPI (https://www.amiiboapi.com/)
- Displays Amiibos in a grid view with images and names
- Supports searching for Amiibos by name
- Allows users to save their favorite Amiibos to a list using Shared Preferences
- Shows Amiibo usage information when a user selects an Amiibo


## Dependencies

The app uses the following dependencies:

- `http`: For making API requests
- `shared_preferences`: For saving favorite Amiibos locally
- `flutter/material.dart`: For UI components

## Project Structure

The main files and folders in the project include:

- `main.dart`: The entry point of the app.
- `LoadingScreen.dart`: A loading screen displayed while fetching Amiibo data from the API.
- `AmiiboGridViewPage.dart`: The main page that displays Amiibos in a grid view and allows users to search for specific Amiibos.
- `MyAmiiboList.dart`: A page that displays the user's favorite Amiibos.
- `ShowUsagePage.dart`: A page that shows the usage information for a selected Amiibo.
