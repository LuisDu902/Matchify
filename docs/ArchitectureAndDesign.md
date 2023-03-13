
## Architecture and Design
In this section we'll describe the logical and physical architectures of our project.

### Logical architecture

The logical architecture of our application is divided into two main sections: External Services and Matchify System.

External Services englobes the Spotify API and the Firebase.

Matchify System has the following packages:

* Matchify GUI: responsible for drawing the widgets and the screens of the app and allows the interaction between the app and the user.

* Matchify Authentication: responsible for the authentication of the user.
  
* Matchify Business Logic: imports songs from the Spotify API, enables users to create playlists and connects the app to the database.

* Matchify Database Schema: manages the database so information can be retrieved and uploaded.

 <p align="center" justify="center">
  <img src="/images/logical_architecture.png"/>
</p>

### Physical architecture

In our app's physical architecture a mobile device is necessary
to interact with the application made in Dart.

The mobile device connects to the Firebase server
which features the realtime database where all the information created by
the app is stored.

It also connect to the Spotify API is used in order to fetch songs and functionalities.

 <p align="center" justify="center">
  <img src="/images/physical_architecture.png"/>
</p>


### Vertical prototype
To help on validating all the architectural, design and technological decisions made, we usually implement a vertical prototype, a thin vertical slice of the system.

In this subsection please describe which feature you have implemented, and how, together with a snapshot of the user interface, if applicable.

At this phase, instead of a complete user story, you can simply implement a feature that demonstrates thay you can use the technology, for example, show a screen with the app credits (name and authors).

