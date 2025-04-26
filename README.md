# Contact List Manager - Back End

## Approximate Time Spent

10 hours

## Description

I built a contact list manager app where you can create, view, update, and delete contacts. I also added functionality allowing you to add multiple notes to the contacts. The notes have full crud (Create, Read, Update, Delete) functionality as well, specific to each contact. I added a vanilla JWT authentication flow, ensuring not to use a built in auth flow like Devise. The JWT auth allows you to login and register as a user. Each user has unique contacts that they manage with notes as well.

## Technologies Used

- Ruby  
- Ruby on Rails
- Javascript


## Instructions

To run this Ruby on Rails application locally, follow these steps:

- Ensure you have Ruby and Rails installed — if you need instructions, [check out this walkthrough](https://guides.rubyonrails.org/install_ruby_on_rails.html).

- Clone the repository to your local machine:
  ```bash
  git clone https://github.com/Nam3loc/linq_backend_contactlistmanager.git
  ```
- Navigate into the project directory:  
  ```bash
  cd backend_contact_notes_system/linq_softwareengineer_project
  ```
- Install the necessary gems:  
  ```bash
  bundle install
  ```
- Set up the database:  
  ```bash
  rails db:create db:migrate db:seed
  ```
- Start the Rails server:  
  ```bash
  bin/rails server
  ```
- Visit `http://localhost:3000` in your browser to use the application.

## Documentation

- Authentication Documentation: [view](https://docs.google.com/document/d/1xvD6N0KjfhXJXuuJfbGCAEzWIhHEpTXJtY0sRez1W9w/edit?usp=sharing)
- Contacts Documentation: [view](https://docs.google.com/document/d/1gLzXMJ4CTEj9iZyiiv2fHi12M2MasZ0lwilJWmSqJe0/edit?usp=sharing)
- User Creation: [view](https://docs.google.com/document/d/1oIQJqjSWPMapC3EsamM8ibTtXZR-OIPsCZ88QfhsQBI/edit?usp=sharing)
- Testing JWT Authentication with Postman: [view](https://docs.google.com/document/d/1RvC9BWw-qD6ik9oJw_QYVkPq2U1UIXcWJpWTYdJ0_lk/edit?usp=sharing)
- Testing Get Contacts with JWT Authentication with Postman and on the FE: [view](https://docs.google.com/document/d/1vg4IN18JwRt_gJVQgvdE6rxxaacVRH3UAmNaZ79XtLc/edit?usp=sharing)
- Create/Edit Note using Body in Postman: [view](https://docs.google.com/document/d/1d3TH42BoavQMo8adFji31hhSn7QRffs55aiUyIBGOgc/edit?usp=sharing)

## Trade Offs

I extended the application I originally built during my software engineering technical interview. That caused me to continue to use Rails which I am new too. This was a great learning experience! I was able to learn a lot of the way that Rails organizes backend applications and it is very simple, user friendly, and fun to use.

The trade offs were a lack of knowledge so it took a lot of learning and tinkering. I did not see a time limit listed in the instructions for this assignment but I still did not want to spend too long on this project as a whole. Because of that, I stopped before I was able to add unit tests or a queue or event bus to decouple note creation from indexing or processing. 

## Future Implementations

In the future, I would love to expand this project by:

- Adding a full React frontend to improve the user experience.

- Using Devise for authentication for more robust user management (registration, login, logout).

- Building a full test suite to ensure code quality and long-term support.

- Expanding note features (e.g., favoriting contacts/notes, tagging, or advanced filtering).

- Improving token handling to better mimic production-level UX, including background token refreshes.

Currently, token expiry is demonstrated with a short 5-minute expiration and notification system. While useful for showcasing functionality, this would be adjusted for production applications to prevent disruptions to the user experience.

## Walkthrough

You can view a walkthrough of the Contact List Manager [here](https://www.loom.com/share/d2c457575bc04ba78a45463e89008367).

[https://www.loom.com/share/d2c457575bc04ba78a45463e89008367]
