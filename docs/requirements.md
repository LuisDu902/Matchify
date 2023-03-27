
## Requirements


### Domain model

The domain model of our application is composed by 7 classes.

* `User:` contains information about every user that uses the app, including an unique ID, a username and a password. The last two fields are for the login. A user can be friend of other users.


* `Playlist:` contains a user specified number of songs and is identified by a name.


* `Song:` contains information about every song, such as: name, artist and album (optional).


* `Filter and respective subclasses:` contains information about all the different filters the user can apply to their search.



 <p align="center" justify="center">
  <img src="/images/domain_model.png"/>
</p>


