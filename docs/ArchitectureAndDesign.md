
## Architecture and Design
In this section we'll describe the logical and physical architectures of our project.

### Logical architecture

The logical architecture of our application is divided into two main sections: `External Services` and `Matchify System`.

Matchify System has the following packages:

* `Matchify GUI:` responsible for drawing the widgets and the screens of the app and allows the interaction between the app and the user.

* `Matchify Authentication:` responsible for the authentication of the user.

* `Matchify Business Logic:` imports songs from the Spotify API, enables users to create playlists and connects the app to the database.

* `Matchify Database Schema:` manages the database so information can be retrieved and uploaded.

External Services englobes:

*  `Spotify API: `  allows developers to interact with the Spotify platform and retrive data related to music, artists, albums, and playlist. 

*  `Firebase: ` manages user authentication (Firebase Auth) and stores data in real-time across multiple clients (Firebase Realtime Database)

 <p align="center" justify="center">
  <img src="/images/logical_architecture.png"/>
</p>

### Physical architecture

In our app's physical architecture, a mobile device is necessary
to interact with the application made in Dart.

The mobile device connects to the Firebase server
which features the realtime database where all the information created by
the app is stored and manages user authentication of our application.

It also connects to the Spotify API. This API is used in order to fetch songs and functionalities.

 <p align="center" justify="center">
  <img src="/images/physical_architecture.png"/>
</p>


### Vertical prototype

We have started implementing the following features (detailed in the user stories): Choosing Filters, Selecting Playlist Size, Swiping Left or Right to choose songs.

We have also implemented a sidebar.

The swiping feature is not working 100% well on the emulator but it works perfectly if you use a real smart phone, when you try to swipe you must do it on the album cover image (for now).

The code displayed is not yet properly formatted so some screens might have some display bugs.

Here is a preview (the gif takes time to load): 


<p align="center" justify="center">
  <img width=300 src="/images/prototype.gif"/>
</p>
