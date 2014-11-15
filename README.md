# Dialoggr

## Project Overview

Dialoggr is a tool for communication in lecture and discussion formats. Leaders and participants can use this application for questions and feedback. This was one of my final projects as a student at MakerSquare.


## Technology

I built this using:

1. Ruby on Rails
2. Active Record
3. SQLite (changed to PostGres for deploy to Heroku)
4. WebSockets (for automatic updating)
5. JavaScript & jQuery
6. RSpec & Capybara for testing


## User Stories

A Discussion Leader can...

1. Create a new discussion with a Leader Code (password) to view the Leader page
2. Create surveys to send out to all participants
3. Send surveys immediately or create them to send later
4. End surveys now or set a timer to end them later
5. View participant responses once the surveys have been ended
6. View & respond to participant questions
7. View previous student questions and leader responses

A Discussion Participant can...

1. View the Participant page for a discussion
2. Respond to Leader surveys
3. Create and send questions to the Leader
4. View participant questions that the leader has already responded to


## Potential Additions
+ Allow Leaders to delete discussions
+ Allow Leaders to send a variety of survey types (e.g. multiple choice)
+ Incorporate authentication to only allow certain participants to view discussions
+ Incorporate badges on the tabs to show users when a new question/survey has been sent
+ Allow Leaders to select x number of random particpant responses rather than viewing the entire group
+ Build a mobile app


