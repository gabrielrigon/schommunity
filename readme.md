# Schommunity
### Collaborative system for students and school

This project aims to bring students and teachers closer to an institution, providing a tool that facilitates communication in general.

**The system includes administrative functions such as**:
- Registered educational institutions (where every user must be bound to use the system)
- Course management for institutions, courses for courses, classrooms for disciplines
- User registration (students, teachers, coordinators, and directors)

**The main functionalities of the system are**:
- Posting template within the classrooms (forum)
  - Allows within each post users include comments 
  - Will be displayed only to users who belong to the classroom, classroom teacher, and course coordinator

**Chat**
  - Allows all users who have some type of link (classrooms) to exchange messages with each other.

## Installation requirements
- Ruby 2.3.0
- PostgreSQL 9.6
- Elasticsearch 2.4.5
- Gem bundler preinstalled
- ImageMagick

## System installation
1. Clone the project
2. Access the folder and install the gems with the following command:
```sh
  $ bundle install
```
3. Rename `database.yml.duplicate` file to `database.yml` (located inside the `/config` folder) and edit the settings according to your installed postgres database.
4. Start the PostgreSQL database service.
5. Execute the following commands to install the database, do the initial setup and feed with standard data:
```sh
  $ bundle exec rake db:setup
```
6. Start the `Elasticsearch` service
7. Start the project with the command below:
```sh
  $ rails s
```

Performed the above steps, the project will be running.

## Using the system
To use the system, open the browser and go to `localhost:3000`, the login screen will be loaded. The only pre-created user is the administrator with email `admin@admin.com` and `qwerty` as password.

From this moment on, you will have to configure the institution structure, defining a `director` type of access that will later be used to access the system already inside the institution's register, where it will be possible to register teachers and students to assign it to the institution, the classrooms.

## Extra information
- All user registrations as soon as they are inserted in the database will receive an email with a token to register the password, for this functionality was used [Devise] (https://github.com/plataformatec/devise) and [Devise Invitable] (https://github.com/scambra/devise_invitable)
- In addition to sending the token to the user, the system indexes this user's registration, allowing a faster search in the datatables, performed by Elasticsearch with [Searchkick] (https://github.com/ankane/searchkick)
- The permission management was built with [CanCanCan] (https://github.com/CanCanCommunity/cancancan)
- The system does not use subdomains to control access to institutions
