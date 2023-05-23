
## Requirements


### Domain model

The domain model of our application is composed by 7 classes.

* User: contains information about every user that uses the app, including an unique ID, a username and a password. The last two fields are for the login. A user can friend many users and can have many playlists. 

* Playlist: contains a user specified number of songs and is identified by a name. A playlist is created by either one or more users  (in case it is a mixed playlist), it must have a minimum of 5 songs and cannot exceed 60 songs.


* Song: contains information about every song, such as: name, artist and album (optional). Each song can belong to many playlists.


* Filter and respective subclasses: contains information about all the different filters the user can apply to their search.

 <p align="center" justify="center">
  <img src="/images/domain_model.png"/>
</p>


