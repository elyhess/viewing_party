<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** github_username, repo_name, twitter_handle, email, project_title, project_description
-->

<!-- Shields -->
![](https://img.shields.io/badge/Rails-5.2.4-informational?style=flat&logo=<LOGO_NAME>&logoColor=white&color=2bbc8a)
![](https://img.shields.io/badge/Ruby-2.5.3-orange)


![Viewing Party](https://github.com/foymikek/viewing_party/blob/main/header.png)
<!-- TABLE OF CONTENTS -->
<summary><h2 style="display: inline-block">Table of Contents</h2></summary>
<ol>
  <li><a href="#about-the-project">About The Project</a>
  <li><a href="#project-board">Project Board</a></li>
  <li><a href="#database-schema">Database Schema</a></li>
  <li><a href="#built-with">Built With</a>
  <li><a href="#setup-instructions">Setup Instructions</a></li>
  <li><a href="#contact">Contact</a></li>
  <li><a href="#acknowledgements">Acknowledgements</a></li>
</ol>

<!-- ABOUT THE PROJECT -->
## About The Project

[Viewing Party](https://viewi.herokuapp.com/) is an application for friends to enjoy a movie night together. Users can search movies, create viewing parties, and invite friends to attend.

User stories tracked using [Github projects](https://github.com/foymikek/viewing_party/projects/1).

<!-- PROJECT BOARD -->
## Project Board
Check out the [Project board](https://github.com/foymikek/viewing_party/projects/1) for a complete list of features / user stories used to develop this application.

<!-- DATABBASE SCHEMA -->
## Database Schema

![Schema](https://github.com/elyhess/viewing_party/blob/main/schema.png)

<!-- BUILT WITH -->
## Built With

* [Ruby on Rails](https://rubyonrails.org/)
* [Postgresql](https://www.postgresql.org/)
* [Bootstrap](https://getbootstrap.com/)
* [MovieDB API](https://developers.themoviedb.org/3/getting-started/introduction)


<!-- SETUP INSTRUCTIONS -->
## Setup Instructions
To get a local copy up and running follow these simple steps.

1. Clone the repo
   ```
   git clone https://github.com/elyhess/viewing_party
   ```
2. Install dependencies
   ```
   bundle install
   ```
3. DB creation/migration
   ```
   rails db:create
   rails db:migrate
   rails db:seed
   ```
3. Run tests and view test coverage
   ```
   bundle exec rspec
   open coverage/index.html
   ```
4. Run server and navigate to http://localhost:3000/
   ```
   rails s
   ```
OR

1. Visit heroku
   ```
   https://viewi.herokuapp.com/
   ```

<!-- CONTACT -->
## Contact

* [Robert Heath](robert.b.heathii@gmail.com) - robert.b.heathii@gmail.com
* [Michael Foy](foymikek@gmail.com) - foymikek@gmail.com
* [Ely Hess](https://github.com/elyhess) - ely.hess@me.com


<!-- ACKNOWLEDGEMENTS -->
## Acknowledgements

* [README template](https://github.com/othneildrew/Best-README-Template)
* [Turing School of Software & Design](https://github.com/turingschool-examples/viewing_party)
* [MovieDB](https://developers.themoviedb.org/3/getting-started/introduction)